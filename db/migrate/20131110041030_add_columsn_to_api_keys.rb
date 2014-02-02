class AddColumsnToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :consumer_key, :string
    add_column :api_keys, :consumer_secret, :string
    add_column :api_keys, :token, :string
    add_column :api_keys, :token_secret, :string
  end
end
