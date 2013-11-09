class Post < ActiveRecord::Base
  belongs_to :sub
  has_one :content_type
end
