# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create 20 users with job_seeker role
# 20.times do |i|
#   User.create!(
#     full_name: "User #{i + 1}",
#     email: "user#{i + 1}@example.com",
#     password: "password123",
#     telegram_user_id: format('%07d', rand(10000000)),
#     role: "job_seeker"
#   )
# end


# Create around 14 job applications for job_id 1
# "https://arki-aws-bucket.s3.amazonaws.com/cvs/Algebra_Cheat_Sheet.pdf"
14.times do |i|
  user = User.where(user_id: [2, 4, 5, 6, 7, 8, 9, 10, 11]).sample
  JobApplication.create!(
    user: user,
    job_id: 1,
    contact: "https://t.me/kbmati9",
    cv_document_url: "https://arki-aws-bucket.s3.amazonaws.com/cvs/Algebra_Cheat_Sheet.pdf",
    cover_letter: "Cover letter for #{user.full_name}. " * 20
  )
end