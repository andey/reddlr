# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  reddit_id       :string(255)      not null
#  title           :string(255)      not null
#  sub_id          :integer          not null
#  tumblr_id       :string(255)
#  content_type_id :integer
#  submitted_at    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#  json            :hstore
#  whitelist_id    :integer
#  garbage         :boolean
#  processed_at    :datetime
#  response        :hstore
#

require 'json'
class Post < ActiveRecord::Base
  acts_as_taggable
  belongs_to :sub
  belongs_to :whitelist
  belongs_to :content_type
  validates :reddit_id, uniqueness: true

  scope :queue, -> { where(submitted_at: nil).where.not(content_type_id: nil).order(:created_at) }

  # Filter out reddit self posts from the start
  before_save :check_if_self_post, :check_content_type, :check_whitelist

  def check_if_self_post
    if self.json['is_self'] == 'true' || self.json['is_self'] == true
      self.garbage = true
    end
  end

  def check_content_type
    ContentType.all.each do |ct|
      regex = Regexp.new ct.url_match
      self.content_type_id = ct.id if regex.match(self.json['url'])
    end
  end

  def check_whitelist
    if whitelist = Whitelist.find_by(domain: self.json['domain'])
      regex = Regexp.new whitelist.url_match
      self.whitelist_id = whitelist.id if whitelist.url_match && regex.match(self.json['url'])
    end
  end

  def remove
    api_key = ApiKey.where(enabled: true).order(:updated_at).first
    client = api_key.tumblr_client
    if client.delete(self.tumblr_subdomain, self.tumblr_id)
      self.update_attribute(:removed_at, Time.now)
    end
  end

  def url
    self.json['url']
  end

  def source
    "http://reddit.com#{self.json['permalink']}"
  end

  def reddit_url
    "http://reddlr.com/posts/#{self.reddit_id}/comments"
  end

  def post_title
    self.title
  end

  def tumblr_subdomain
    "reddlr-#{self.sub.name.downcase}.tumblr.com"
  end

end
