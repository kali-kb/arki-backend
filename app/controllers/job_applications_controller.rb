class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: %i[ show update destroy ]
  before_action :authorize_request, only: [:create, :destroy]
  # GET /job_applications
  # GET /job_applications.json
  def index
    logger.info "executed"
    if params[:user_id] && !params[:job_id]
      @job_applications = User.find(params[:user_id]).job_applications
    elsif params[:user_id]
      @job_applications = JobApplication.joins(:job).where(jobs: { user_id: params[:user_id], job_id: params[:job_id] })
      logger.info "job applications for user #{params[:user_id]}: #{@job_applications}"    
    else
      @job_applications = JobApplication.all
    end
    render "index"
  end

  # GET /job_applications/1
  # GET /job_applications/1.json
  def show
  end

  # POST /job_applications
  # POST /job_applications.json
  def create
    logger.info "current user: #{@current_user}"

    @job = Job.find_by(job_id: params[:job_id])
    
    if @job.nil?
      render json: { error: "Job not found" }, status: :not_found
      return
    end

    @job_application = @job.job_applications.build(job_application_params)
    @job_application.user = @current_user


    if JobApplication.exists?(job_id: params[:job_id], user_id: @current_user.id)
      render json: { error: "You have already applied for this job" }, status: :unprocessable_entity
    else
      if @job_application.save
        render json: @job_application, status: :created
      else
        render json: @job_application.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /job_applications/1
  # PATCH/PUT /job_applications/1.json
  def update
    if @job_application.update(job_application_params)
      render :show, status: :ok, location: @job_application
    else
      render json: @job_application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /job_applications/1
  # DELETE /job_applications/1.json
  def destroy
    @job_application.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = JobApplication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_application_params
      params.require(:job_application).permit(:job_application_id, :contact, :user_id, :job_id, :cv_document_url, :cover_letter)
    end

    def set_user
      @current_user = User.find(params[:user_id])
    end


    def authorize_request
      user = User.find(params[:user_id])
      if request.request_method == "POST"
        if user.role == "job_seeker"
          @current_user = user
        else
          render json: { errors: 'Unauthorized' }, status: :unauthorized
        end
      else
        application = JobApplication.find(params[:id])
        if user.role != "job_seeker" && application.job.user_id == user.user_id
          @current_user = user
        else
          render json: { errors: 'Unauthorized' }, status: :unauthorized
        end
      end
    end
end
