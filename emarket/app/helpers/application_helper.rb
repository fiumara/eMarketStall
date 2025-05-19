module ApplicationHelper
    def t_google(text)
        TranslationService.translate(text, session[:lingua] || "it")
      end
end
