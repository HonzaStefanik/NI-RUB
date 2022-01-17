class CreateQuizzes < ActiveRecord::Migration[6.0]
  def up
    create_table :quiz do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
    end
  end
end