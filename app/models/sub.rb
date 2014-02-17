# == Schema Information
#
# Table name: subs
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  css        :text
#  js         :text
#

class Sub < ActiveRecord::Base
  acts_as_taggable
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  scope :nsfw, -> { where(nsfw: true) }
  scope :sfw, -> { where(nsfw: false) }
  has_many :posts, dependent: :destroy
end
