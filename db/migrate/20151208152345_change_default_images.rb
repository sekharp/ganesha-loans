class ChangeDefaultImages < ActiveRecord::Migration
  def change
    change_column_default :users, :image_file_name, nil
    change_column_default :projects, :image_file_name, nil
  end
end
