class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :text, null: false
      t.integer :upvotes, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
