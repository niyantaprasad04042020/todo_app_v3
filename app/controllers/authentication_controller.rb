class AuthenticationController < ApplicationController
	 before_action :authorize_request, except: %i[login new]

  def new 
  end

  # POST /auth/login
  def login
    @user = User.find_by(email_id: params[:email_id])
    if @user&.authenticate(params[:password])
      if @user.confirmed_at?
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       email: @user.email_id }, status: :ok
      else
        render json: {error: 'Email not verified' }, status: :unauthorized
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email_id, :password)
  end
end
