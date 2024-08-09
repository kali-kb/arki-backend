class Job < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_jobs, against: :title, using: { tsearch: { prefix: true } }
  belongs_to :user
  has_many :saved_job, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  enum job_site: { on_site: "On-Site", remote: "Remote" }
  enum status: { in_review: "in-review", approved: "approved", declined: "declined" }
  enum education_level: { tvet: "TVET", secondary_school: "Secondary School", certificate: "Certificate", diploma: "Diploma", bachelors_degree: "Bachelors Degree", masters_degree: "Masters Degree", phd_doctoral_degree: "PHD. Doctoral Degree", not_required: "Not Required" }
  enum employment_type: { full_time: "Full-Time", part_time: "Part-Temp", freelance: "Freelance", contract: "Contract", volunteership: "Volunteership", internship: "Internship", unpaid_internship: "Unpaid Internship" }
  # has_many :job_applications
  # has_many :applicants, through: :job_applications
  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :job_site, presence: true, inclusion: { in: job_sites.keys }
  validates :city, presence: true
  validates :description, presence: false, length: { maximum: 4000 }
  validates :education_level, inclusion: { in: education_levels.keys }
  validates :employment_type, presence: true, inclusion: { in: employment_types.keys }
  validates :salary, allow_blank: true, numericality: { only_integer: true, greater_than: 0 }  
  validates :vacancies, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :status, presence: true, inclusion: { in: statuses.keys }

end
