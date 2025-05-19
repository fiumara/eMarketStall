# app/controllers/lingua_controller.rb
class LinguaController < ApplicationController

    def seleziona
        @lingue = {
          "it" => "Italiano",
          "en" => "English",
          "fr" => "Français",
          "es" => "Español",
          "de" => "Deutsch"
        }
      end
    
      def cambia
        session[:lingua] = params[:lingua]
        redirect_back fallback_location: root_path, notice: "Lingua cambiata in #{params[:lingua]}"
      end
  end
  