class AddContentsToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :practice_content, :string
  end
end
