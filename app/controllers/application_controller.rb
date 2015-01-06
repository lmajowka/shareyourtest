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
    @ga_id = 'UA-55397368-1'
    parsed_locale = request.host.split('.').last
    if parsed_locale == 'br'
      @country = 'br'
      @ga_id = 'UA-58059688-1'
      return :'pt-BR'
    end
    @country = 'us'
    nil
  end

end
