class CreateEngineers < ActiveRecord::Migration[5.2]
  def change
    create_table :engineers do |t|
      t.string :name
      t.string :url
      t.integer :idorigin

      t.timestamps
    end
    add_index :engineers, :idorigin, unique: true
  end
end
