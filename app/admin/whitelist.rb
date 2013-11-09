ActiveAdmin.register Whitelist do
  controller do
    def permitted_params
      params.permit(:whitelist => [:name, :regex, :tumblr_type_id])
    end
  end
end
