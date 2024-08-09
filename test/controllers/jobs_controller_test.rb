require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = jobs(:one)
  end

  test "should get index" do
    get jobs_url, as: :json
    assert_response :success
  end

  test "should create job" do
    assert_difference("Job.count") do
      post jobs_url, params: { job: { city: @job.city, description: @job.description, education_level: @job.education_required, employment_type: @job.employment_type, job_id: @job.job_id, job_site: @job.job_site, salary: @job.salary, status: @job.status, title: @job.title, user_id: @job.user_id, vacancies: @job.vacancies } }, as: :json
    end

    assert_response :created
  end

  test "should show job" do
    get job_url(@job), as: :json
    assert_response :success
  end

  test "should update job" do
    patch job_url(@job), params: { job: { city: @job.city, description: @job.description, education_required: @job.education_required, employment_type: @job.employment_type, job_id: @job.job_id, job_site: @job.job_site, salary: @job.salary, status: @job.status, title: @job.title, user_id: @job.user_id, vacancies: @job.vacancies } }, as: :json
    assert_response :success
  end

  test "should destroy job" do
    assert_difference("Job.count", -1) do
      delete job_url(@job), as: :json
    end

    assert_response :no_content
  end
end
