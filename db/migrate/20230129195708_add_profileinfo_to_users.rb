class AddProfileinfoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :city, :string
    add_column :users, :education, :string
    add_column :users, :work, :string
  end
end
