# == Schema Information
#
# Table name: content_types
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  tumblr_type_id :string(255)      not null
#  created_at     :datetime
#  updated_at     :datetime
#  url_match      :string(255)
#

class ContentType < ActiveRecord::Base
  belongs_to :tumblr_type
end
