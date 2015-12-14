class GeoJson < ActiveRecord::Migration
  def change
    create_table :geo_json do |t|
      t.integer :state_id, null: false, index: true, required: true
      t.integer :county_id, null: false, index: true, required: true
      t.jsonb :geo_object, null: false, required: true
    end

    execute <<-SQL
      CREATE INDEX index_geo_json_on_geometry ON geo_json USING gin((geo_object->'geometry'));
    SQL
  end
end
