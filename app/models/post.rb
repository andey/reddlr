require 'json'
class Post < ActiveRecord::Base
  belongs_to :sub
  belongs_to :whitelist
  has_one :content_type
end
