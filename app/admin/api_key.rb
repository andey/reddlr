ActiveAdmin.register ApiKey do
  controller do
    def permitted_params
      params.permit(:api_key => [:username, :consumer_key, :consumer_secret, :token, :token_secret])
    end
  end
end