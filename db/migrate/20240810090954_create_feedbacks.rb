class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks, id:false do |t|
      t.primary_key :feedback_id
      t.references :user, null: false, foreign_key: { to_table: :users, primary_key: "user_id" }
      t.string :feedback_text

      t.timestamps
    end
  end
end
