require 'cgi'
require 'oauth2'
require 'json'

module Rixi
  SITE = 'http://api.mixi-platform.com'
  AUTH_URL ='https://mixi.jp/connect_authorize.pl'
  TOKEN_URL ='https://secure.mixi-platform.com/2/token'

  def initialize(params={ })
    Rixi::Client.new(params)
  end
end
