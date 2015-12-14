class Counties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.integer :county_code, null: false, index: true, required: true
      t.string :county_name, null: false, required: true
    end

    add_reference :counties, :state, index: true, foreign_key: true
    add_reference :epa_records, :county, index: true, column: :county_code, foreign_key: true

    add_index :epa_records, [:state_id, :county_code]
    add_index :counties, [:state_id, :county_code], unique: true
  end
end
