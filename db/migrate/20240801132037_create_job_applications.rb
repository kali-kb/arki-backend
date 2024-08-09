class CreateJobApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :job_applications, id:false do |t|
      t.primary_key :job_application_id
      t.references :user, null: false, foreign_key: { to_table: :users, primary_key: "user_id" }
      t.references :job, null: false, foreign_key: { to_table: :jobs, primary_key: "job_id" }
      t.text :contact
      t.text :cv_document_url, null:false
      t.text :cover_letter, null:false
      t.timestamps
    end
  end
end
