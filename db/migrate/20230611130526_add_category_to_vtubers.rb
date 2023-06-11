class AddCategoryToVtubers < ActiveRecord::Migration[6.1]
  def change
    add_column :vtubers, :category, :string
  end
end
