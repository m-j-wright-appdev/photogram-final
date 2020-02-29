class AddCountsToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :likes_count, :integer
    add_column :photos, :comments_count, :integer
  end
end
