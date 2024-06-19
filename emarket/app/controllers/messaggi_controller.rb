class MessaggiController < ApplicationController
  before_action :authenticate_acquirente!
  
  def index
    @messaggi = Messaggio.all
  end
end
