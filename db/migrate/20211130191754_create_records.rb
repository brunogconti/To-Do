class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.string :event_type
      t.json :proporties
      t.integer :task

      t.timestamps
    end
  end
end
