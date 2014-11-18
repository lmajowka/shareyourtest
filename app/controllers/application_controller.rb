class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :set_locale

  def set_locale
    I18n.locale = extract_locale_from_tld || I18n.default_locale
  end

  def not_found
    render 'not_found'
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    if parsed_locale == 'br'
      return :'pt-BR'
    end
    nil
  end

end
