ActiveAdmin.register Post do
  actions :index, :show

  index do
    column :title
    column :sub
    column :created_at
    column :whitelist
    column :content_type_id
    column :garbage
    column :submitted_at
    default_actions
  end
end
