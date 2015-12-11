class Counties < ActiveRecord::Migration
  def change
    create_table :counties, id: false do |t|
      t.integer :id, null: false, index: true, required: true
      t.integer :state_id, null: false, index: true, required: true
      t.string :county_name, null: false, required: true
    end

    add_index :counties, [:id, :state_id], unique: true
    add_foreign_key :counties, :states

    execute <<-SQL
      ALTER TABLE counties ADD PRIMARY KEY (id, state_id);
    SQL
  end
end
