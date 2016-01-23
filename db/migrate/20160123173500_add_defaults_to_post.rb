class AddDefaultsToPost < ActiveRecord::Migration
  def change
    change_column_default :topics, :sticky, false
    change_column_default :topics, :lock, false
  end
end
