      class GestioneAccountController < ApplicationController
        before_action :authenticate_amministratore!
        def manage
          @users = User.all
        end
      end
      
      
