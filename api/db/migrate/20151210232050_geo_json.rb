class GeoJson < ActiveRecord::Migration
  def change
    create_table :geo_json do |t|
      t.integer :state_num_code, null: false, index: true, required: true
      t.integer :county_num_code, null: false, index: true, required: true
      t.jsonb :geo_object, null: false, required: true
    end

    add_index :geo_json, [:county_num_code, :state_num_code], unique: true

    execute <<-SQL
      CREATE INDEX index_geo_json_on_geometry ON geo_json USING gin((geo_object->'geometry'));
    SQL
  end
end
