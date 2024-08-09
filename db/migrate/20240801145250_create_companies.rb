class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies, id:false do |t|
      t.primary_key :company_id
      t.references :user, null: false, foreign_key: { to_table: :users, primary_key: "user_id" }, index: {unique: true}
      t.string :company_name, null:false
      t.string :city, null:false
      t.text :logo_img_url
      t.text :description
      t.string :industry
      t.string :website
      t.string :tin_no

      t.timestamps
    end
  end
end
