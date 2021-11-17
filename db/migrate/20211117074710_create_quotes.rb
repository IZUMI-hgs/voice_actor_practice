class CreateQuotes < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :title, null: false
      t.string :quote_image, null: true
      t.string :opposite_voice, null: true
      t.integer :emotion, null: false, default: 0

      t.timestamps
    end
    add_index :quotes, :title, unique: true
    add_index :quotes, :quote_image, unique: true
    add_index :quotes, :opposite_voice, unique: true
  end
end
