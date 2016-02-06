class AddDefaultToUserAndProjectImages < ActiveRecord::Migration
  def change
    change_column_default(:projects, :image_file_name, 'http://cliparts.co/cliparts/Lid/5A6/Lid5A66zT.png')
    change_column_default(:users, :image_file_name, 'http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg')
  end
end
