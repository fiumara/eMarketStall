module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.id
    end

    private

    def find_verified_user
      # Modifica questa parte in base a come verifichi l'autenticazione dell'utente.
      if current_user = User.find_by(id: cookies.signed[:user_id]) # Adatta a seconda del nome del tuo modello
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end

