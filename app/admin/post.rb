ActiveAdmin.register Post do
  controller do
    def permitted_params
      params.permit(:post => [:title, :content_type_id])
    end
  end
end
