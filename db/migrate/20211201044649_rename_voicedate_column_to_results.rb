class RenameVoicedateColumnToResults < ActiveRecord::Migration[6.0]
  def change
    rename_column :results, :voice_date, :voice_data
  end
end
