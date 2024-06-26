class GestioneCampagneController < ApplicationController
  def index
     @promozioni = Promozioni.all
   end
end
