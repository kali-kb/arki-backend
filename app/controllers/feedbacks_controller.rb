class FeedbacksController < ApplicationController
  before_action :set_feedback, only: %i[ show update destroy ]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      render :show, status: :created, location: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    if @feedback.update(feedback_params)
      render :show, status: :ok, location: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feedback_params
      params.require(:feedback).permit(:feedback_id, :user_id, :feedback_text)
    end
end
