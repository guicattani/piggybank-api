class CreateSavings < ActiveRecord::Migration[6.0]
  def change
    create_table :savings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :value_in_cents
      t.date :objective_date
      t.integer :objective_value_in_cents
      t.string :currency
      t.string :color

      t.timestamps
    end
  end
end
