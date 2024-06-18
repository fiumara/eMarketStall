class MessaggiController < ApplicationController
  def index
    @messaggi = Messaggio.all
  end
end
