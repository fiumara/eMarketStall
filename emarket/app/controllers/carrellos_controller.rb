class CarrellosController < ApplicationController
    before_action :authenticate_acquirente!
  
    def show
      @carrello = current_user.carrello
    end

    def checkout
      redirect_to new_ordine_path
    end
  end
  
