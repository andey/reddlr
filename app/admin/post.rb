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
#

ActiveAdmin.register Post do
  config.sort_order = "created_at_desc"
  actions :all, :except => [:create, :new]

  scope :all, default: true
  scope :queue
  scope :successful
  scope :failed
  scope :garbage

  controller do
    def permitted_params
      params.permit(:post => [:title, :sub_id, :content_type_id, :whitelist_id, :tumblr_id])
    end
  end

  filter :sub
  filter :content_type
  filter :whitelist
  filter :title
  filter :reddit_id
  filter :tumblr_id

  index do
    column :created_at
    column :sub
    column :title
    column :content_type_id
    column :submitted_at
    column :tumblr_id
    actions
  end

  show do |ama|
    attributes_table do
      row :title
      row :sub
      row :reddit_id
      row :tumblr_id
      row :created_at
      row :processed_at
      row :submitted_at
      row :garbage
      row :json
      row :response
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :title
      f.input :sub
      f.input :content_type
      f.input :whitelist
      f.input :tumblr_id
    end

    f.actions do
      f.action :submit
      f.action :cancel
    end
  end
end
