class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :user do |t|
      t.string :username
      t.string :password
      t.string :salt
    end
  end
end