class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :state_name, null: false, required: true
      t.string :abbreviation, limit: 2, null: false, required: true
    end
  end
end
