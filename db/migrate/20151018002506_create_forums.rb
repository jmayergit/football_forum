class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name,       default: "", null: false
      t.boolean :private,   default: false, null: false

      t.timestamps
    end
  end
end
