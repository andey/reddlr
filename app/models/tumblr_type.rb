# == Schema Information
#
# Table name: tumblr_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class TumblrType < ActiveRecord::Base
end
