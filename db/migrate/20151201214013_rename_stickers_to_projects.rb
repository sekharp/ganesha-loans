class RenameStickersToProjects < ActiveRecord::Migration
  def change
    rename_table :stickers, :projects
  end
end
