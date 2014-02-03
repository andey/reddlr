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
end
