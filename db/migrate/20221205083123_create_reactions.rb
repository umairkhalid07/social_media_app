class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.boolean :reaction_type, null: true
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
  end
end
