class CreateStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :styles do |t|
      t.integer :user_id
      t.float :weight
      t.float :height
      t.float :bodyfat
      t.float :leftarm
      t.float :rightarm
      t.float :body
      t.float :leftleg
      t.float :rightleg

      t.timestamps
    end
  end
end
