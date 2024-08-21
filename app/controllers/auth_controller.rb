class AuthController < ApplicationController
    def login
        user = User.find_by(email: params[:email])
        logger.info "User: #{user.inspect}"
        if user && user.authenticate(params[:password])
            render json: {message: "Login successful", user: user}, status: :ok
        else
            render json: {error: "Invalid email or password"}, status: :unprocessable_entity
        end
    end
end
