class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.references :engineer, foreign_key: true
      t.string :employer
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
