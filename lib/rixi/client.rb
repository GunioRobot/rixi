require 'rixi/request'
require 'rixi/utils'
require 'rixi/authentication'

module Rixi
  class Facade < OAuth2::Client
    include Rixi::Facade::Request
    include Rixi::Facade::Utils
    include Rixi::Facade::Authenticate
    
    attr_reader :redirect_uri, :scope, :token
    
    def initialize(params={ })
      if params[:consumer_key] == nil && params[:consumer_secret] == nil
        raise "Rixi needs a consumer_key or consumer_secret."
      end
      
      _id  = params.delete :consumer_key
      _secret = params.delete :consumer_secret
      @redirect_uri    = params.delete :redirect_uri
      @scope           = scope_to_query(params.delete(:scope))
      
      params.merge!({
        :site => SITE,
        :authorize_url => AUTH_URL,
        :token_url => TOKEN_URL    
      })
      super(_id,_secret,params)

      self
    end
  end


end
