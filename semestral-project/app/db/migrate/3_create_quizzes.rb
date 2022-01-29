class CreateQuizzes < ActiveRecord::Migration[6.0]
  def up
    create_table :quizzes do |t|
      t.string :name
      t.text :description
      t.belongs_to :user, foreign_key: true
    end
  end
end