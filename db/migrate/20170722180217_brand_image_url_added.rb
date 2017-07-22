class BrandImageUrlAdded < ActiveRecord::Migration[5.1]
  def change
    add_column(:brands, :image_url,:string)
  end
end
