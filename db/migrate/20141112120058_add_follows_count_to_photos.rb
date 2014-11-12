class AddFollowsCountToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :follows_count, :integer, :default => 0
  end
end
