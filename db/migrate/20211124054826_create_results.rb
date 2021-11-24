class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.string :uuid, null: false
      t.references :quote, null: false, foreign_key: true
      t.string :result_message
      t.string :voice_date

      t.timestamps
    end
    add_index :results, :uuid, unique: true
  end
end
