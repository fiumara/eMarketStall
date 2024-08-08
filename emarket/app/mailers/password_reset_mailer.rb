class PasswordResetMailer < ApplicationMailer
    default from: 'no-reply@tuodominio.com'
  
    def password_reset
      @user = params[:user]
      mail(to: @user.email, subject: 'Recupero password')
    end
  end
  