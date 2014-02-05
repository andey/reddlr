class AddResetDateToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :reset_at, :timestamp, :default => Time.now
  end
end
