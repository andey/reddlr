ActiveAdmin.register TumblrType do
  controller do
    def permitted_params
      params.permit(:tumblr_type => [:name])
    end
  end
end
