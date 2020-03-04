class AddSavingTransaction < ActiveRecord::Migration[6.0]
  def change
    create_table :saving_transactions do |t|
      t.references :saving, null: false, foreign_key: true
      t.integer :value_in_cents
      t.boolean :scheduled, default: false, null: false

      t.timestamps
    end
  end
end
