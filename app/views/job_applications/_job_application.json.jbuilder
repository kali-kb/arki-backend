json.extract! job_application, :job_application_id, :user_id, :job_id, :cv_document_url, :contact, :cover_letter, :created_at, :updated_at
json.url job_application_url(job_application, format: :json)
