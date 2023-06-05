class CreateVtuberComments < ActiveRecord::Migration[6.1]
  def change
    create_table :vtuber_comments do |t|

      t.timestamps
    end
  end
end
