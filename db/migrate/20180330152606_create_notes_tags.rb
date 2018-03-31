class CreateNotesTags < ActiveRecord::Migration[5.1]
  def change
    create_table :notes_tags, :id => false do |t|
      t.references :note, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
