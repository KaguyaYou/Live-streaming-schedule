class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.string :vtuber_name
      t.string :belonging_office
      t.string :fan_name
      t.datetime :debut_day
      t.integer :registered_person
      t.string :profile
      t.timestamps
    end
  end
end
