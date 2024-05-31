class SessionsController < ApplicationController
  def new
  end

  def create
    user = if params[:role] == 'acquirente'
             Acquirente.find_by(email: params[:email])
           elsif params[:role] == 'amministratore'
             Amministratore.find_by(email: params[:email])
           end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:role] = params[:role]
      redirect_to root_path, notice: "Accesso effettuato!"
    else
      flash.now[:alert] = "Email o password non validi"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:role] = nil
    redirect_to root_path, notice: "Disconnessione effettuata!"
  end
end
