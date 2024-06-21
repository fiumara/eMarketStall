      class GestioneAccountController < ApplicationController
        before_action :authenticate_amministratore!

        def manage
          @acquirente = Acquirente.all
        end
      end
      
      
