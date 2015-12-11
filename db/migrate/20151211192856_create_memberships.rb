class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user, dependant: :destroy
      t.belongs_to :forum, dependant: :destroy

      t.timestamps
    end

    add_index :memberships, :user_id
    add_index :memberships, :forum_id
  end
end
