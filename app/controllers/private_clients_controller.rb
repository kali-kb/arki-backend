class PrivateClientsController < ApplicationController
  before_action :set_private_client, only: %i[ show update destroy ]

  # GET /private_clients
  # GET /private_clients.json
  def index
    @private_clients = PrivateClient.all
  end

  # GET /private_clients/1
  # GET /private_clients/1.json
  def show
  end

  # POST /private_clients
  # POST /private_clients.json
  def create
    @private_client = PrivateClient.new(private_client_params)

    if @private_client.save
      render :show, status: :created, location: @private_client
    else
      render json: @private_client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /private_clients/1
  # PATCH/PUT /private_clients/1.json
  def update
    if @private_client.update(private_client_params)
      render :show, status: :ok, location: @private_client
    else
      render json: @private_client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /private_clients/1
  # DELETE /private_clients/1.json
  def destroy
    @private_client.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_private_client
      @private_client = PrivateClient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def private_client_params
      params.require(:private_client).permit(:private_client_id, :location, :user_id, :verification_type, :verification_document_url)
    end
end
