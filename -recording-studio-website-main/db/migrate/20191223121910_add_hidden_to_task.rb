class AddHiddenToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :hidden, :boolean
  end
end
