class GeoJson < ActiveRecord::Migration
  def change
    create_table :geo_json do |t|
      t.integer :state_code, null: false, index: true, required: true
      t.integer :county_code, null: false, index: true, required: true
      t.jsonb :geo_object, null: false, required: true
    end

    add_index :geo_json, [:county_code, :state_code], unique: true
    add_foreign_key :geo_json, :states, column: :state_code, primary_key: :state_code

    execute <<-SQL
      CREATE INDEX index_geo_json_on_geometry ON geo_json USING gin((geo_object->'geometry'));
    SQL
  end
end
