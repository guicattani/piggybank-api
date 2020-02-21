class CreateSavingSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :saving_schedules do |t|
      t.boolean :active
      t.integer :value_in_cents
      t.string :description
      t.string :period
      t.integer :period_value

      t.timestamps
    end
  end
end
