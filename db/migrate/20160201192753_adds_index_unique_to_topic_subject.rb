class AddsIndexUniqueToTopicSubject < ActiveRecord::Migration
  def change
    add_index :topics, :subject, unique: true
  end
end
