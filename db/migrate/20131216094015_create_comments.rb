class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :entry_id
      t.integer :user_id_cmt

      t.timestamps
    end
    # add_index :comments, :entry_id
    # add_index :comments, :user_id_cmt
    add_index :comments, [:entry_id, :user_id_cmt, :created_at]
  end
end