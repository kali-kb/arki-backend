class JobsController < ApplicationController
  before_action :set_job, only: %i[ show update destroy ]

  # GET /jobs
  # GET /jobs.json
  def index
    logger.info "executed"
    # if params[:q]
    if params[:user_id]
      @jobs = Job.where(user_id: params[:user_id])
    elsif !params[:user_id] && params[:q]
      #implement search
      search_term = params[:q]
      @jobs = Job.search_jobs(search_term)
      
    else
      @jobs = Job.all
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    if @job
      render :show
    else
      render json: { error: 'Job not found' }, status: :not_found
    end
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.user_id = params[:user_id]
    user = User.find_by(user_id: params[:user_id])
    if user && user.role != "job_seeker"
      if @job.save
        render :show, status: :created
      else
        render json: @job.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized. Only non-job seekers can create jobs.' }, status: :unauthorized
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    if @job.update(job_params)
      render :show, status: :ok
      # render :show, status: :ok, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    if @job
      @job.destroy!
    else
      render json: { error: 'Job not found' }, status: :not_found
    end
  end

  private

    def set_job
      if params[:user_id] && params[:id]
        @job = Job.find_by(user_id: params[:user_id], job_id: params[:id])
      else
        @job = Job.find_by(job_id: params[:id])
      end
    end

   
    def job_params
      params.require(:job).permit(:job_id, :title, :job_site, :city, :description, :education_level, :experience_required, :employment_type, :salary, :vacancies, :status, :deadline)
    end
end
