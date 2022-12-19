class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.timestamps
    end
    add_index :conversations, :sender_id
    add_index :conversations, :receiver_id
  end
end
