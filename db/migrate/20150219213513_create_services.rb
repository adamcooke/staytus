class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, :permalink
      t.integer :position
      t.timestamps null: false
    end
  end
end
