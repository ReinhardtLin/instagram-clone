class AddLogoToPhotos < ActiveRecord::Migration
  def change
    add_attachment :photos, :logo
  end
end
