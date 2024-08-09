json.extract! company, :id, :company_id, :user_id, :company_name, :city, :logo_img_url, :description, :industry, :website, :tin_no, :created_at, :updated_at
json.url company_url(company, format: :json)
