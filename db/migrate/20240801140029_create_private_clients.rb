class CreatePrivateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :private_clients, id:false do |t|
      t.primary_key :private_client_id
      t.string :location
      t.string :verification_type
      t.text :verification_document_url

      t.timestamps
    end
  end
end
