

      class GestioneAccountController < ApplicationController
        def manage
          @users = User.all
        end
      end
      
      
