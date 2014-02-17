class NsfwSubs < ActiveRecord::Migration
  def change
    add_column :subs, :nsfw, :boolean, default: false
  end
end
