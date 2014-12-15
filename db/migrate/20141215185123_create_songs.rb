class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title, null: false, index: true
      t.string :artist, index: true
      t.string :album, index: true
      t.integer :year, index: true
      t.string :source_url, null: false, index: true

      t.timestamps
    end
  end
end
