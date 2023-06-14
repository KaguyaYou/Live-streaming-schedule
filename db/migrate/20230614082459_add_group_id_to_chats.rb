class AddGroupIdToChats < ActiveRecord::Migration[6.1]
  def change
    add_column :chats, :group_id, :integer
    add_index :chats, :group_id
  end
end
