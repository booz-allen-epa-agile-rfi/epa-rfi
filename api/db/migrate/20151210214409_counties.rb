class Counties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.integer :county_id, null: false, index: true, required: true
      t.integer :state_id, null: false, index: true, required: true
      t.string :county_name, null: false, required: true
      t.jsonb :coordinates, null: false, required: true
    end

    add_index :counties, [:county_id, :state_id], unique: true
  end
end
