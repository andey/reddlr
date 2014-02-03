ActiveAdmin.register Post do
  config.sort_order = "created_at_desc"
  actions :all, :except => [:destroy]

  filter :title
  filter :sub
  filter :content_type_id
  filter :garbage

  index do
    column :created_at
    column :sub
    column :title
    column :content_type_id
    column :submitted_at
    column :garbage
    default_actions
  end
end
