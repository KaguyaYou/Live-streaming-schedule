class CreateVtuberComments < ActiveRecord::Migration[6.1]
  def change
    create_table :vtuber_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :vtuber_id

      t.timestamps
    end
  end
end
