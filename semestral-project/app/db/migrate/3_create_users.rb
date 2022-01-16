class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    # "user" table is already a predefined table in postgres
    create_table :app_user do |t|
      t.string :username
      t.string :password
      t.string :salt
    end
  end
end