class CreateCategoryQuiz < ActiveRecord::Migration[6.0]
  def up
    create_table :categories_quizzes, id: false do |t|
      t.belongs_to :quiz
      t.belongs_to :category
    end
  end
end