json.extract! feedback, :id, :feedback_id, :user_id, :feedback_text, :created_at, :updated_at
json.url feedback_url(feedback, format: :json)
