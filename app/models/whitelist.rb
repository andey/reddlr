# == Schema Information
#
# Table name: whitelists
#
#  id             :integer          not null, primary key
#  domain         :string(255)      not null
#  match          :string(255)
#  replace        :string(255)
#  tumblr_type_id :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#  url_match      :string(255)
#

class Whitelist < ActiveRecord::Base
  belongs_to :tumblr_type
end
