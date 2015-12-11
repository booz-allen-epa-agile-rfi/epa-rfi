class GeoJson < ActiveRecord::Migration
  def change
    create_table :geo_json do |t|
      t.integer :state_id, null: false, index: true, required: true
      t.integer :county_id, null: false, index: true, required: true
      t.jsonb :geo_object, null: false, required: true
    end

    add_foreign_key :geo_json, :states
    # add_foreign_key :geo_json, :countries, column: :state_id
    # add_foreign_key :geo_json, :counties, column: 'county_id, state_id', primary_key: ':id, :state_id'

    execute <<-SQL
      CREATE INDEX index_geo_json_on_geometry ON geo_json USING gin((geo_object->'geometry'));
    SQL

    GeoJson.connection.execute('ALTER TABLE geo_json ADD CONSTRAINT fk_counties_county_state_id FOREIGN KEY (county_id, state_id) REFERENCES counties(id, state_id);')

    # ALTER TABLE geo_json
    # ADD CONSTRAINT fk_counties_county_state_id
    # FOREIGN KEY (state_id, county_id)
    # REFERENCES counties(id, state_id);
  end
end
