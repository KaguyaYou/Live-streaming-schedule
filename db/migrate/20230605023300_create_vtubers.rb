class CreateVtubers < ActiveRecord::Migration[6.1]
  def change
    create_table :vtubers do |t|
      t.string :vtuber_id
      t.string :name
      t.text :body
      t.timestamps
    end
  end
end
