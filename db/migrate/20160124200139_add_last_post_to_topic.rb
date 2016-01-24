class AddLastPostToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :last_post, :datetime
  end
end
