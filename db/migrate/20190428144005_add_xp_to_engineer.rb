class AddXpToEngineer < ActiveRecord::Migration[5.2]
  def change
    add_column :engineers, :xp, :integer
  end
end
