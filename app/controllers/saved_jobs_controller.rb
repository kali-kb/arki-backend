class SavedJobsController < ApplicationController
  before_action :set_saved_job, only: %i[ show update destroy ]
  before_action :authorize
  # GET /saved_jobs
  # GET /saved_jobs.json
  def index
    user_id = params[:user_id]
    @saved_jobs = SavedJob.where(user_id: user_id)
  end

  # GET /saved_jobs/1
  # GET /saved_jobs/1.json
  def show
  end

  # POST /saved_jobs
  # POST /saved_jobs.json
  def create
    user_id = params[:user_id]
    @saved_job = SavedJob.new(user_id: user_id, job_id:saved_job_params[:job_id])
    if SavedJob.exists?(user_id: user_id, job_id: saved_job_params[:job_id])
      render json: { error: "You have already saved this job" }, status: :unprocessable_entity
    else
      if @saved_job.save
        # render :show, status: :created, location: @saved_job
        render :show, status: :created
      else
        render json: @saved_job.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /saved_jobs/1
  # PATCH/PUT /saved_jobs/1.json
  def update
    if @saved_job.update(saved_job_params)
      render :show, status: :ok, location: @saved_job
    else
      render json: @saved_job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /saved_jobs/1
  # DELETE /saved_jobs/1.json
  def destroy
    @saved_job.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saved_job
      @saved_job = SavedJob.find(params[:id])
    end

    def authorize
      user = User.find_by(user_id: params[:user_id])
    
      unless user&.is_job_seeker?
        render json: { error: "Only job seekers can access this resource" }, status: :unauthorized
        return
      end
    
      if request.put? || request.delete?
        @saved_job = SavedJob.find(params[:id])
        unless @saved_job.user.user_id == user.user_id
          render json: { error: "You are not authorized to modify this saved job" }, status: :unauthorized
          return
        end
      end
    
      @current_user = user
    end
    # Only allow a list of trusted parameters through.
    def saved_job_params
      params.require(:saved_job).permit(:job_id)
    end
end
