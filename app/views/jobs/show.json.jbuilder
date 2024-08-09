# json.partial! "jobs/job", job: @job
json.partial! "jobs/job", job: @job
json.user do
  json.extract! @job.user, :id, :email, :role
  
  if @job.user.role == 'company'
    json.company do
      json.extract! @job.user.company, :id, :company_name, :city, :description, :tin_no
    end
  elsif @job.user.role == 'private_client'
    json.private_client do
      json.extract! @job.user.private_client, :id, :location, :verification_type, :verification_document_url
    end
  end
end
