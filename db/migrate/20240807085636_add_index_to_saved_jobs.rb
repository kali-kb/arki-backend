class AddIndexToSavedJobs < ActiveRecord::Migration[7.1]
  def change
    add_index :saved_jobs, [:user_id, :job_id]
  end
end
