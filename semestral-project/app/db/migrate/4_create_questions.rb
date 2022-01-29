class CreateQuestions < ActiveRecord::Migration[6.0]
  def up
    create_table :questions do |t|
      t.text :question
      t.belongs_to :quiz, foreign_key: true
    end
  end
end