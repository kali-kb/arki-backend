class CreateSavedJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :saved_jobs, id:false do |t|
      t.primary_key :saved_job_id
      t.references :user, null: false, foreign_key: {to_table: :users, primary_key: 'user_id'}
      t.references :job, null: false, foreign_key: {to_table: :jobs, primary_key: 'job_id'}
      t.timestamps
    end
  end
end
