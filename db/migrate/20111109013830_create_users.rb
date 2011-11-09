class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password
      t.string :username
      t.string :profile_picture

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
