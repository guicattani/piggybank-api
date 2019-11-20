class CreateSavings < ActiveRecord::Migration[6.0]
  def change
    create_table :savings do |t|
      t.references :users, null: false, foreign_key: true
      t.integer :value_in_cents
      t.date :objetive_date
      t.integer :objective_value_in_cents
      t.string :color

      t.timestamps
    end
  end
end
