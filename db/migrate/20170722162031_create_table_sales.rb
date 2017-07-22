class CreateTableSales < ActiveRecord::Migration[5.1]
  def change
    create_table(:sales)do |t|
      t.column(:store_id, :int)
      t.column(:brand_id, :int)
      t.column(:price, :string)
      t.column(:stock, :int)
      t.timestamps()
    end
  end
end
