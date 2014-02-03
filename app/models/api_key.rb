# == Schema Information
#
# Table name: api_keys
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  consumer_key    :string(255)
#  consumer_secret :string(255)
#  token           :string(255)
#  token_secret    :string(255)
#

class ApiKey < ActiveRecord::Base

  def tumblr_client
    Tumblr::Client.new(
        consumer_key: self.consumer_key,
        consumer_secret: self.consumer_secret,
        oauth_token: self.token,
        oauth_token_secret: self.token_secret
    )
  end
end
