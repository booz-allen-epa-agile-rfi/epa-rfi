class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.integer :state_code, null: false, required: true
      t.string :state_name, null: false, required: true
      t.string :abbreviation, limit: 2, null: false, required: true
    end

    add_index :states, :state_code, unique: true

    add_foreign_key :epa_records, :states, column: :state_code, primary_key: :state_code
  end
end
