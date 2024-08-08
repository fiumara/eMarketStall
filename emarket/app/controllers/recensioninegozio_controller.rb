class RecensioninegozioController < ApplicationController
    def index
        @recensioni = Recensione.all
      end
end
