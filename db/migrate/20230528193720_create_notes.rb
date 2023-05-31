class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :name
      t.text :content
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
