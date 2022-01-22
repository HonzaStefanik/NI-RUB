class CreateCategoryQuiz < ActiveRecord::Migration[6.0]
 def up
   create_join_table :categories, :quizzes
   #create_table :categories_quizzes, id: false do |t|
   #  t.belongs_to :quiz, foreign_key: true
   #  t.belongs_to :category, foreign_key: true
   #end
#
   #alter_table :quizzes do |t|
   #  t.has_many
   #end
 end
end