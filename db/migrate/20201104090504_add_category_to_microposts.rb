class AddCategoryToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :practice_category, :string
  end
end
