class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :state_name, null: false, required: true
      t.string :abbreviation, limit: 2, null: false, required: true
    end

    add_reference :epa_records, :state, index: true, foreign_key: true
  end
end
