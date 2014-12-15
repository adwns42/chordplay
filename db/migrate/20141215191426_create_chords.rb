class CreateChords < ActiveRecord::Migration
  def change
    create_table :chords do |t|
      t.string :name, null: false, index: true
      t.string :song, index: true

      t.timestamps
    end
  end
end
