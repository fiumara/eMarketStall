class CategoriasController < ApplicationController
  def show
    @categorium = Categorium.find(params[:id])
    @prodottos = @categorium.prodottos
  end
end
