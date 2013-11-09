class AddCdnToSub < ActiveRecord::Migration
  def change
    add_column :subs, :css, :text
    add_column :subs, :js, :text
  end
end
