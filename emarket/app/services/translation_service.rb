require 'net/http'
require 'uri'
require 'json'
require 'cgi'

class TranslationService
  GOOGLE_TRANSLATE_URL = "https://translation.googleapis.com/language/translate/v2"

  def self.translate(text, target_lang, source_lang = nil)
    return text if text.blank?

    cache_key = "translation:#{text}:#{target_lang}"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      uri = URI(GOOGLE_TRANSLATE_URL)

      query_params = {
        q: text,
        target: target_lang,
        key: ENV['GOOGLE_TRANSLATE_API_KEY']
      }

      query_params[:source] = source_lang if source_lang.present?

      uri.query = URI.encode_www_form(query_params)

      res = Net::HTTP.get_response(uri)
      json = JSON.parse(res.body)

      if res.is_a?(Net::HTTPSuccess)
        translated = json["data"]["translations"].first["translatedText"]
        CGI.unescapeHTML(translated)
      else
        Rails.logger.error("Translation API error: #{json}")
        text # fallback in caso di errore
      end
    end
  end
end
