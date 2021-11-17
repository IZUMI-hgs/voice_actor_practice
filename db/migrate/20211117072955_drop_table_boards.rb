class DropTableBoards < ActiveRecord::Migration[6.0]
  def up
    drop_table :boards
  end

  def down
    create_table :boards do |t|
      t.string :title
      t.string :text

      t.timestamps
    end
  end
end
