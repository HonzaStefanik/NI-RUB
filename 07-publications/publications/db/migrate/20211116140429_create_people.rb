class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :full_name
      t.string :email
      t.string :username
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
