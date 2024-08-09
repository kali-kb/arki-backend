class JobApplication < ApplicationRecord
  # has_one_attached :cv_document
  belongs_to :user
  belongs_to :job
  validates :cv_document_url, presence: true
  validates :cover_letter, presence: true, length: { maximum: 1000 }
end
