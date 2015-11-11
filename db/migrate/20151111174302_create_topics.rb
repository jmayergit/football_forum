class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :subject,        default: "Delete"
      t.belongs_to :forum,      index: true
      t.belongs_to :user,       index: true

      t.timestamps
    end
  end
end
