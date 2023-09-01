class RemoveisActiveFromitems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :is_active, :is_active
  end
end
