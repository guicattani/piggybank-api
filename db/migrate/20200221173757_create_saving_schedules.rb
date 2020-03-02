class CreateSavingSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :saving_schedules do |t|
      t.boolean :active, default: true
      t.integer :value_in_cents
      t.string :description
      t.string :period
      t.integer :period_value

      t.date :next_date
      t.timestamps
    end
  end
end
