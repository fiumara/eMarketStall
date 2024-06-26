class MessaggiController < ApplicationController
  before_action :authenticate_user!

  def index
    @messaggi = Messaggio.all
  end

  def show
    @messaggi = Messaggio.all
  end

  private

  
end
