require 'cgi'
require 'oauth2'
require 'activesupport'
require_relative 'rixi/rixi_utils'
require_relative 'rixi/rixi_request'
require_relative 'rixi/rixi_auth'

class Rixi
  include Utils
  attr_reader :consumer_key, :consumer_secret, :redirect_uri, :token, :client
  
  SITE = 'http://api.mixi-platform.com'
  AUTH_URL ='https://mixi.jp/connect_authorize.pl'
  TOKEN_URL ='https://secure.mixi-platform.com/2/token'

  def initialize(params = { })
    if params[:consumer_key] == nil && params[:consumer_secret] == nil
      raise "Rixi needs a consumer_key or consumer_secret."
    end
    
    @consumer_key    = params.delete :consumer_key
    @consumer_secret = params.delete :consumer_secret
    @redirect_uri    = params.delete :redirect_uri
    @scope           = scope_to_query(params.delete(:scope))
    
    params.merge!({
      :site => SITE,
      :authorize_url => AUTH_URL,
      :token_url => TOKEN_URL    
    })
    @client = OAuth2::Client.new(
          @consumer_key,
          @consumer_secret,
          params
    )
  end
  
end
