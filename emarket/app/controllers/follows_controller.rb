class FollowsController < ApplicationController
  before_action :authenticate_acquirente!

  def create
    negozio = Negozio.find(params[:negozio_id])
    current_user.follows.create(negozio: negozio)
    redirect_to negozio_path(negozio), notice: "Hai iniziato a seguire il negozio."
  end

  def destroy
    follow = current_user.follows.find_by(negozio_id: params[:negozio_id])
    follow.destroy if follow
    redirect_to negozio_path(params[:negozio_id]), notice: "Hai smesso di seguire il negozio."
  end
end
