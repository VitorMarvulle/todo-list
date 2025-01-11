class RegistrationsController < ApplicationController
  allow_unauthenticated_access(only: %i[new create])
  before_action :resume_session, only: [:new]
  rate_limit to: 10, within: 1.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Tente novamente mais tarde." }

  def new
    redirect_to root_url if authenticated?
  end

  def create
    user = User.new(params.permit(:email_address, :password))
    if user.save
      # Remove a linha que inicia a sessão automaticamente
      redirect_to new_session_url, notice: "Cadastro realizado com sucesso! Faça login para continuar."
    else
      redirect_to new_session_url, alert: user.errors.full_messages.to_sentence
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_url, notice: "Sessão encerrada."
  end
end
