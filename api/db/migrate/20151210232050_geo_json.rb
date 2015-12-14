class GeoJson < ActiveRecord::Migration
  def change
    create_table :geo_json do |t|
      t.jsonb :geo_object, null: false, required: true
      t.integer :county_code, index: true
    end

    add_reference :geo_json, :state, index: true, foreign_key: true
    add_reference :geo_json, :county, index: true, column: :county_code, foreign_key: true
    add_reference :epa_records, :geo_json, index: true, foreign_key: true

    add_index :geo_json, [:state_id, :county_code], unique: true

    execute <<-SQL
      CREATE INDEX index_geo_json_on_geometry ON geo_json USING gin((geo_object->'geometry'));
    SQL
  end
end