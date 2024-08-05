class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = Acquirente.find_by(email: params[:email]) || Amministratore.find_by(email: params[:email])
    if @user
      @user.generate_password_reset_token!
      # Invia l'email con il link per il reset della password
      PasswordResetMailer.with(user: @user).password_reset.deliver_later
      redirect_to root_path, notice: "Email di recupero password inviata."
    else
      flash[:alert] = "Email non trovata."
      render :new
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
    redirect_to root_path, alert: "Token non valido" unless @user
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user.update(password_params)
      @user.clear_password_reset_token!
      redirect_to login_path, notice: "Password aggiornata con successo."
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
