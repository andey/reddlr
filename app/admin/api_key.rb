ActiveAdmin.register ApiKey do
  controller do
    def permitted_params
      params.permit(:api_key => [:username, :consumer_key, :consumer_secret, :token, :token_secret])
    end
  end

  index do
    column :username
    column :day_count
    column :historical_count
    column :reset_at
    column :updated_at
    column :consumer_key
    column :enabled
    default_actions
  end
end