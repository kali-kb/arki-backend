json.array! @jobs do |job|
  json.partial! "jobs/job", job: job
  json.user do
    json.partial! "users/user", user: job.user
    if job.user.role == "company"
      json.company do
        json.partial! "companies/company", company: job.user.company
      end
    elsif job.user.role == "private_client"
      json.private_client do
        json.partial! "private_clients/private_client", private_client: job.user.private_client
      end
    end
  end
end
