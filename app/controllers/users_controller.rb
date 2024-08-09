class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  # after_action :create_employer_profile, only: %i[ create ]

  # GET /users
  # GET /users.json
  def index
    if params[:by_telegram] && params[:by_telegram] == "true"
      @user = User.find_by(telegram_user_id: params[:tg_id])
      if @user
        render "users/show_by_telegram"
      else
        render json: {error: "Not Found"}, status: :not_found
      end
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    if @user.save
      if @user.role == "private_client"
        @private_client = PrivateClient.new(private_client_params)
        @private_client.user_id = @user.user_id
        @private_client.save
      elsif @user.role == "company"
        @company = Company.new(company_params)
        @company.user_id = @user.user_id
        @company.save
      end
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:full_name, :email, :password, :telegram_user_id, :role)
    end

    def private_client_params
      params.require(:private_client).permit(:location, :verification_type, :verification_document_url)
      # Add other private client-specific parameters here
    end
    
    def company_params
      params.require(:company).permit(:company_name, :city, :industry, :logo_img_url, :tin_no, :company_description, :website, :company_logo_url)
    end
end
