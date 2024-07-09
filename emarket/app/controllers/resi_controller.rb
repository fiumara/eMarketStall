class ResiController < ApplicationController
    def index
        @resi = Reso.all
      end
    
      def update
        @reso = Reso.find(params[:id])
        if params[:commit] == "accetta"
          @reso.update(stato: "Accettato")
        elsif params[:commit] == "rifiuta"
          @reso.update(stato: "Rifiutato")
        end
        redirect_to resi_path
      end
end
