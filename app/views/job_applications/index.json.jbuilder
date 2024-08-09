json.array! @job_applications do |job_application|
  json.partial! "job_applications/job_application", job_application: job_application
  json.job do
    json.partial! "jobs/job", job: job_application.job
  end
end
