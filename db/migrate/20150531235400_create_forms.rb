class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :name, default: ""
      t.text :body, default: ""
      t.boolean :submitted, default: false
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :forms, :user_id
  end
end
