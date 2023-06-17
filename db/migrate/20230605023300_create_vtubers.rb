class CreateVtubers < ActiveRecord::Migration[6.1]
  def change
    create_table :vtubers do |t|
      t.string :name
      t.integer :user_id
      t.string :belonging_office
      t.string :fan_name
      t.date :debut_day
      t.integer :registered_person
      t.string :profile
      t.boolean :status,default: true
      t.timestamps
    end
  end
end
