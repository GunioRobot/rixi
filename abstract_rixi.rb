require 'oauth2'
require 'activesupport'

module Rixi
  SITE = 'http://api.mixi-platform.com'
  AUTH_URL ='https://mixi.jp/connect_authorize.pl'
  TOKEN_URL ='https://secure.mixi-platform.com/2/token'

  def initialize(params={ })
    Rixi::Client.new(params)
  end
end

module Rixi
  class Client
    module Authenticate
      def authorize_url
        self.auth_code.super(:scope => @scope)
      end
      
      def get_token(code)
        @token = self.auth_code.super(code, {:redirect_uri => @redirect_uri}, {:mode => :header, :header_format => "OAuth %s"})
        return self
      end
      
      def set_token()      
      end

    end
  end
end

module Rixi
  class Client
    module Utils
      def scope_to_query
      end
    end
  end
end

module Rixi  
  class Client < OAuth2::Client
    attr_reader :token, :redirect_url, :scope
    
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

module Rixi
  class Client
    include Rixi::Client::Authenticate
    include Rixi::Client::Utils
  end
end


