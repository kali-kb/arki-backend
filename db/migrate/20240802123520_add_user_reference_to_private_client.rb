class AddUserReferenceToPrivateClient < ActiveRecord::Migration[7.1]
  def change
    add_reference :private_clients, :user, null: false, foreign_key: { to_table: :users, primary_key: "user_id" }, index: {unique: true}
  end
end
