class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = Acquirente.find_by(email: params[:email])
    if @user
      token = @user.create_reset_digest
      PasswordResetMailer.with(user: @user, token: token).reset_email.deliver_now
      redirect_to login_path, notice: "Ti abbiamo inviato un'email con le istruzioni per reimpostare la password."
    else
      flash.now[:alert] = "Email non trovata"
      render :new
    end
  end

  def edit
    @user = Acquirente.find_by(id: params[:id])     # ✅ CORRETTA
    @token = params[:token]
    unless @user&.reset_token_valid?(@token)
      redirect_to new_password_reset_path, alert: "Link non valido o scaduto"
    end
  end
  
  def update
    @user = Acquirente.find_by(id: params[:id])     # ✅ CORRETTA
    @token = params[:token]
    if @user&.reset_token_valid?(@token)
      if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        @user.clear_reset_digest
        redirect_to login_path, notice: "Password aggiornata correttamente."
      else
        flash.now[:alert] = "Errore nell'aggiornamento della password"
        render :edit
      end
    else
      redirect_to new_password_reset_path, alert: "Token non valido"
    end
  end
  
end
