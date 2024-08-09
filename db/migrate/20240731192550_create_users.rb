class CreateUsers < ActiveRecord::Migration[7.1]
def change
    create_enum :user_roles, ["job_seeker", "private_client", "company"]
    create_table :users, id: false do |t|
      t.primary_key :user_id
      t.string :full_name
      t.string :email
      t.string :password
      t.string :telegram_user_id, null:false
      t.enum :role, enum_type: :user_roles,  null:false

      t.timestamps
    end
  
    add_index :users, :telegram_user_id
    add_index :users, :email
  end
end
