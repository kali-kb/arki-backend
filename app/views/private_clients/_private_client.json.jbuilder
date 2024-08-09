json.extract! private_client, :id, :private_client_id, :location, :verification_type, :verification_document_url, :created_at, :updated_at
json.url private_client_url(private_client, format: :json)
