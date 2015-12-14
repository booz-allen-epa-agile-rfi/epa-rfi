class TempCounties < ActiveRecord::Migration
  def change
    create_table :temp_counties do |t|
      t.integer :state_code, null: false, index: true, required: true
      t.integer :county_code, null: false, index: true, required: true
      t.string :county_name, null: false, required: true
      t.jsonb :coordinates, null: false, required: true
    end
  end
end
