# -*- coding: utf-8 -*-
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

      def set_token(access_token, refresh_token, expires_in)
        @token = OAuth2::AccessToken.new(self,
                                         access_token,
                                         {:refresh_token => refresh_token,
                                           :expires_in => expires_in,
                                           :expires_at => 900,
                                           :mode => :header,
                                           :header_format => "OAuth %s"})                                         
        self
      end
    end
  end
end
