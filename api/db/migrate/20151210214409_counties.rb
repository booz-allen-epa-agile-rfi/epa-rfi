class Counties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.integer :state_num_code, null: false, index: true, required: true
      t.integer :county_num_code, null: false, index: true, required: true
      t.string :county_name, null: false, required: true
      t.jsonb :coordinates, null: false, required: true
      t.references :geo_json, index: true
    end

    add_index :counties, [:county_num_code, :state_num_code], unique: true
  end
end
