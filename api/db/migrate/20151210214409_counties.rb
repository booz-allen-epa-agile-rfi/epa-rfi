class Counties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.integer :state_code, null: false, index: true, required: true
      t.integer :county_code, null: false, index: true, required: true
      t.string :county_name, null: false, required: true
      t.jsonb :coordinates, null: false, required: true
      t.references :geo_json, index: true
    end

    add_index :counties, [:county_code, :state_code], unique: true

    add_foreign_key :counties, :states, column: :state_code, primary_key: :state_code
  end
end
