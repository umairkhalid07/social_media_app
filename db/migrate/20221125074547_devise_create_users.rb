class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name, default: ""
      t.text :bio, default: ""
      t.string :phone_number, default: ""
      t.string :location, default: ""
      t.datetime :birthday_at, default: ""
      t.boolean :already_voted, null: true

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
