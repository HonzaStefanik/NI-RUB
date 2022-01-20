class CreateCategoryQuiz < ActiveRecord::Migration[6.0]
  def up
    create_table :categories_quizzes, id: false do |t|
      t.belongs_to :quiz, foreign_key: true
      t.belongs_to :category, foreign_key: true
    end
  end
end