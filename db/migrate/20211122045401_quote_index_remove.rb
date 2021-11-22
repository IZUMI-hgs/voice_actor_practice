class QuoteIndexRemove < ActiveRecord::Migration[6.0]
  def up
    remove_index :quotes, :quote_image
    remove_index :quotes, :opposite_voice
  end
  def down
    add_index :quotes, :quote_image, unique: true
    add_index :quotes, :opposite_voice, unique: true
  end
end
