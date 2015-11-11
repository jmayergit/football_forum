class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :topic, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
