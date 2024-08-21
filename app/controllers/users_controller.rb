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
    if User.exists?(email: user_params[:telegram_user_id])
      render json: {error: "User with this telegram id already exists"}, status: :unprocessable_entity
    else
      if @user.save
        render :show, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
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
      # params.permit(:full_name, :email, :password, :telegram_user_id, :role)
      params.require(:user).permit(:full_name, :email, :password, :telegram_user_id, :role,  
      private_client_attributes: [
        :location, 
        :verification_type,
        :verification_document_url
      ],
      company_attributes: [
        :company_name,
        :city,
        :industry,
        :logo_img_url,
        :tin_no,
        :company_description,
        :website
      ])
    end

    # def private_client_params
    #   params.require(:private_client).permit(:location, :verification_type, :verification_document_url)
    #   # Add other private client-specific parameters here
    # end
    
    # def company_params
    #   params.require(:company_attributes).permit(:company_name, :city, :industry, :logo_img_url, :tin_no, :company_description, :website)
    # end
end
