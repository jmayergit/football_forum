class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.belongs_to :user, dependant: :destroy
      t.belongs_to :post
    end
  end
end
