# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
 respond_to :json

  private

  def respond_with(resource, options = {})
  binding.pry
    render json: {
      status: {code: 200, message: "user signed in succesfully",
               data: current_user,
              }
    }, status: :ok
  end

  def respond_to_on_destroy
     jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],Rails.application.credentials.fetch(:secret_key_base)).first
     current_user = User.find(jwt_payload['sub'])
     if current_user
       render json: {
        status: {code: 200, message: "Signed out succesfully"}
       }, status: :ok
      else
       render json: {
        status: {code: 401, message: "User has no active session"}
       }, status: :unauthorized
     end
  end
end
