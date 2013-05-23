class AddUserId < ActiveRecord::Migration
 def change
    add_column :users, :userID, :string
  end
end
