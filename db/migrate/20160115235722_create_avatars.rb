class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :image
      t.belongs_to :user

      t.timestamps
    end
  end
end
