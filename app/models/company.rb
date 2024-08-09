class Company < ApplicationRecord
  belongs_to :user
  validates :company_name, presence: true
  validates :city, presence: true
  validates :description, length: { maximum: 4000 }  
  validates :tin_no, presence: true, uniqueness: true
end
