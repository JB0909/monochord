class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.text :content
      t.integer :practice_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    #user_idとcreated_atカラムにインデックス(要素番号)を付与
    add_index :microposts, [ :user_id, :created_at ]
  end
end
