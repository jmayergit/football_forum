class AddStickyLockToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :sticky, :boolean
    add_column :topics, :lock, :boolean
  end
end
