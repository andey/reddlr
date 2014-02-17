ActiveAdmin.register Sub do
  actions :all
  filter :name
  scope :enabled, default: true
  scope :disabled
  scope :sfw
  scope :nsfw
  scope :all

  controller do
    def permitted_params
      params.permit(:sub => [:name, :css, :js, :tag_list, :enabled, :nsfw])
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :tag_list
      f.input :enabled
      f.input :nsfw
      f.input :css
      f.input :js
    end

    f.actions do
      f.action :submit
      f.action :cancel
    end
  end

  show do |ama|
    attributes_table do
      row :name
      row :tag_list
      row :css
      row :js
      row :enabled
      row :nsfw
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
