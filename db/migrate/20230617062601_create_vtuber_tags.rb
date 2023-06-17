class CreateVtuberTags < ActiveRecord::Migration[6.1]
  def change
    create_table :vtuber_tags do |t|
      t.references :vtuber, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
