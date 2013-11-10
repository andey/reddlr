class AddDomainMatchToWhitelist < ActiveRecord::Migration
  def change
    add_column :whitelists, :url_match, :string
  end
end
