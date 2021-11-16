class CreatePublications < ActiveRecord::Migration[6.1]
  def change
    create_table :publications do |t|
      t.string :title
      t.date :published_at
      t.string :abstract
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
