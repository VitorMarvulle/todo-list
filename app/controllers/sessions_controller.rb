class SessionsController < ApplicationController
  allow_unauthenticated_access(only: %i[new create])
  before_action :resume_session, only: [:new]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Tente novamente mais tarde." }

  def new
    redirect_to root_url if authenticated?
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to dashboard_path, notice: "Login realizado com sucesso!."
    else
      redirect_to new_session_url, alert: "Email ou senha incorretos"
    end
  end
  

  def destroy
    terminate_session
    redirect_to root_path, notice: "Sessão encerrada."
  end
end
