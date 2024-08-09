require "test_helper"

class PrivateClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @private_client = private_clients(:one)
  end

  test "should get index" do
    get private_clients_url, as: :json
    assert_response :success
  end

  test "should create private_client" do
    assert_difference("PrivateClient.count") do
      post private_clients_url, params: { private_client: { location: @private_client.location, private_client_id: @private_client.private_client_id, verification_document_url: @private_client.verification_document_url, verification_type: @private_client.verification_type } }, as: :json
    end

    assert_response :created
  end

  test "should show private_client" do
    get private_client_url(@private_client), as: :json
    assert_response :success
  end

  test "should update private_client" do
    patch private_client_url(@private_client), params: { private_client: { location: @private_client.location, private_client_id: @private_client.private_client_id, verification_document_url: @private_client.verification_document_url, verification_type: @private_client.verification_type } }, as: :json
    assert_response :success
  end

  test "should destroy private_client" do
    assert_difference("PrivateClient.count", -1) do
      delete private_client_url(@private_client), as: :json
    end

    assert_response :no_content
  end
end
