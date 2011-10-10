require 'cgi'
require 'oauth2'
require 'json'
require 'rixi/client'

module Rixi 
  SITE = 'http://api.mixi-platform.com'
  AUTH_URL ='https://mixi.jp/connect_authorize.pl'
  TOKEN_URL ='https://secure.mixi-platform.com/2/token'
  
  class << self
    def new(params={ })
      Rixi::Facade.new(params)
    end
  end
end
