class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user, index: true
      t.references :song, index: true
      t.boolean :favorited, default: false

      t.timestamps
    end
  end
end
