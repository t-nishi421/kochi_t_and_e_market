class RenameItemImagesColumnToImage < ActiveRecord::Migration[6.0]
  def change
    rename_column :item_images, :image, :src
  end
end
