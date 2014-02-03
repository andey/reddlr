ActiveAdmin.register Whitelist do
  controller do
    def permitted_params
      params.permit(:whitelist => [:domain, :url_match, :match, :replace, :tumblr_type_id])
    end
  end
end
