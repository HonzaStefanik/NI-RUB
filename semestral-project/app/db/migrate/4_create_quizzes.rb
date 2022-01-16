class CreateQuizzes < ActiveRecord::Migration[6.0]
  def up
    create_table :quiz do |t|
      t.string :name
      t.text :description
    end
  end
end