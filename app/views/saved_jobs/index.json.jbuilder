json.array! @saved_jobs do |saved_job|
    json.partial! "saved_jobs/saved_job", saved_job: saved_job
    json.job do
        json.partial! "jobs/job", job: saved_job.job
    end
end
  