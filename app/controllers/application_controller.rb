class ApplicationController < ActionController::Base
 
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjp7IiRvaWQiOiI2MjZmZDI1YmI5ZmMyNDUyNWI1N2RmNWEifSwiZXhwIjoxNjUxNTgyNDg5fQ.IgXnmEJuyDe5OXeHX5gOx2oX9Ow9hY8PGbqRVPpNjLA"
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end