class CreateQuestions < ActiveRecord::Migration[6.0]
  def up
    create_table :question do |t|
      t.text :question
    end
  end
end