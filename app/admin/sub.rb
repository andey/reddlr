ActiveAdmin.register Sub do
  actions :all
  filter :name

  controller do
    def permitted_params
      params.permit(:sub => [:name, :css, :js, :tag_list])
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :tag_list
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
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
