class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.string :username, index: { unique: true }
      t.string :password_digest
    end
  end
end