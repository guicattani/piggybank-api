class SavingScheduleBelongsToSaving < ActiveRecord::Migration[6.0]
  def change
    add_column :saving_schedules, :saving_id, :bigint, foreign_key: true, null: false
    add_index :saving_schedules, :saving_id, name: "index_saving_schedules_on_saving_id"
  end
end
