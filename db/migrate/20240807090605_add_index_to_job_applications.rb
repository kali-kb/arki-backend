class AddIndexToJobApplications < ActiveRecord::Migration[7.1]
  def change
    add_index :job_applications, [:job_id, :user_id]
  end
end
