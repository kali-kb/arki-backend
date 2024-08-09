class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_enum :job_site_types, ["On-Site", "Remote"]
    create_enum :experience_levels, ["Junior Level", "Mid-Level", "Senior Level"]
    create_enum :education_levels, [
      "TVET",
      "Secondary School",
      "Certificate",
      "Diploma",
      "Bachelors Degree",
      "Masters Degree",
      "PHD. Doctoral Degree",
      "Not Required"
    ]
    create_enum :employment_types, [
      "Full-Time",
      "Part-Time",
      "Freelance",
      "Contract",
      "Volunteership",
      "Internship",
      "Unpaid Internship"
    ]
    create_enum :status_types, ["in-review", "approved", "declined"]
    create_table :jobs, id: false do |t|
      t.primary_key :job_id
      t.references :user, null: false, foreign_key: { to_table: :users, primary_key: 'user_id' }
      t.string :title, null:false
      t.enum :job_site, enum_type: :job_site_types, default: "Remote"
      t.string :city
      t.text :description
      t.enum :experience_required , enum_type: :experience_levels
      t.enum :education_required , enum_type: :education_levels, default: "Not Required"
      t.enum :employment_type, enum_type: :employment_types
      t.integer :salary
      t.integer :vacancies
      t.enum :status, enum_type: :status_types, default: "in-review"
      t.datetime :deadline, null:false
      t.timestamps
    end
    add_index :jobs, :title
  end
end
