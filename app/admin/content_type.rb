ActiveAdmin.register ContentType do
  controller do
    def permitted_params
      params.permit(:content_type => [:name, :tumblr_type_id, :url_match])
    end
  end
end
