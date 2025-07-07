module ApplicationHelper
  def t_google(text)
      TranslationService.translate(text, session[:lingua] || "it")
  end

    
def translated_prodotti_options
Prodotto.all.map { |p| [t_google(p.nome_prodotto), p.id] }
end

def translated_categorie_options
Categorium.all.map { |c| [t_google(c.nome), c.id] }
end

def translated_negozio_prodotti_options(negozio)
negozio.prodottos.map { |p| [t_google(p.nome_prodotto), p.id] }
end

end