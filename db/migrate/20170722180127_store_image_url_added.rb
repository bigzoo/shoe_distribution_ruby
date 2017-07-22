class StoreImageUrlAdded < ActiveRecord::Migration[5.1]
  def change
    add_column(:stores,:image_url,:string)
  end
end
