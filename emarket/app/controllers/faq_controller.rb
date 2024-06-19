class FaqController < ApplicationController
  before_action :authenticate_acquirente!
  
  def index
  end
end
