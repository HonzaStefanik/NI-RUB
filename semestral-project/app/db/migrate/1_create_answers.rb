class CreateAnswers < ActiveRecord::Migration[6.0]
  def up
    create_table :answers do |t|
      t.text :answer
      t.boolean :correct
      t.belongs_to :quiz
    end
  end
end