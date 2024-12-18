class CarrellosController < ApplicationController
    before_action :authenticate_acquirente!
  
    def show
      @carrello = current_user.carrello
    end
  end
  
