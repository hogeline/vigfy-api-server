class AddStartdateAndEnddateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :startdate, :string
    add_column :users, :enddate, :string
  end
end
