class AddPetsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pets, :string, array: true, default: []
  end
end
