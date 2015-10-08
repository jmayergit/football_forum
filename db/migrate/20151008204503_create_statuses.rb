class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :value, null: false, default: "unsanctioned"
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
