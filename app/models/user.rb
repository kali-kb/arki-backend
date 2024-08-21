class User < ApplicationRecord
    has_secure_password validations: false
    has_many :jobs, dependent: :destroy
    has_many :job_applications, dependent: :destroy
    has_many :saved_jobs, dependent: :destroy
    has_one :private_client, dependent: :destroy
    has_one :company, dependent: :destroy
    validates :email, presence: false, uniqueness: { allow_blank: true }
    enum role: { job_seeker: 'job_seeker', private_client: 'private_client', company: 'company' }
    validates :role, inclusion: { in: roles.keys }
    validates :telegram_user_id, presence: true, uniqueness:{ message: "already exists"}
    validates :password, length: { minimum: 6 }, confirmation: true, if: -> { password.present? }
    accepts_nested_attributes_for :company
    accepts_nested_attributes_for :private_client

    def is_employer?
        return true if self.role != "job_seeker"
        return false
    end

    def is_job_seeker?
        return true unless self.role != "job_seeker"
        return false
    end

    def employer_profile
        return self.company if self.role == "company"
        return self.private_client
    end
end
