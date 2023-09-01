class RemoveIsActiveFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :is_active, :boolean
  end
end
