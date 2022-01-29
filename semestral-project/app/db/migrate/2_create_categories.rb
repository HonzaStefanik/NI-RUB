class CreateCategories < ActiveRecord::Migration[6.0]
  def up
    create_table :categories do |t|
      t.string :name
      t.text :description
    end
  end
end