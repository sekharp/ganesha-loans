class AddStatusAndRemoveRetiredFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :retired, :boolean
    add_column :projects, :status, :string
  end
end
