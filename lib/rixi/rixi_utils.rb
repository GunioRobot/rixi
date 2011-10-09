module Rixi
  module Utils
    # scope as hash to query
    def scope_to_query(scope)
      if scope.kind_of?(Hash)
        return scope.map {|key, value|
          key.to_s if value
        }.join(" ")
      else
        return scope || "r_profile"
      end
    end

    def parse_response(response)
      res = response.response.env
      case res[:status].to_i
      when 400...600
        puts "API ERROR: status_code=" + res[:status].to_s
        JSON.parse(res[:body])
      else
        JSON.parse(res[:body])
      end
    end
  end

end
