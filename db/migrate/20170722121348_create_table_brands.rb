class CreateTableBrands < ActiveRecord::Migration[5.1]
  def change
    create_table(:brands)do |t|
      t.column(:name, :string)
      t.column(:release_date, :date)
      t.column(:manufacturer, :string)
      t.timestamps()
    end
  end
end
