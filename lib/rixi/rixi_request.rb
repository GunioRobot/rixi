# -*- coding: utf-8 -*-
require_relative 'rixi_utils'

# Rixiで実際にHTTPリクエストをする部分
module Rixi
  class Client
    module Request
      def get(path, params = { })
        extend_expire()
        parse_response(@token.get(path, :params => params))
      end

      def post(path, params = { })
        extend_expire()
        parse_response(@token.post(path,:params => params))
      end

      def delete(path, params = { })
        extend_expire()
        @token.delete(path, :params => params).response.env[:status].to_s
      end

      def put(path, params = { })
        extend_expire()
        parse_response(@token.put(path, :params => params))
      end

      # 画像 は params[:image], タイトルは params[:title]で渡す
      # 画像はバイナリ文字列で渡す
      def post_image(path, params = { })
        extend_expire()
        path += "?title="+ CGI.escape(params[:title]) if params[:title]
        parse_response(@token.post(path,{
                                     :headers => {
                                       :content_type  => "image/jpeg",
                                       :content_length => params[:image].size.to_s,
                                     },:body   => params[:image]}))
      end

      # params[:json]はハッシュで渡して関数内でJSON化する
      def post_json(path, params = { })
        extend_expire()
        parse_response(@token.post(path,{
                                     :headers => {
                                       :content_type  => "application/json; charset=utf-8",
                                       :content_length => params[:json].size.to_s
                                     },:body   => params[:json]}))
      end

      # JSON形式＋写真を投稿することが可能なAPIについて
      def post_multipart(path, params ={ })
        extend_expire()
        if params[:image]
          now = Time.now.strftime("%Y%m%d%H%M%S")
          content_type = "multipart/form-data; boundary=boundary#{now}"
          body  = application_json(now,params[:json])
          body << attach_photos(now,params[:image])
          body << end_boundary(now)
        else
          content_type = "application/json"
          body = params[:json].to_json
        end

        parse_response(@token.post(path,{
                                     :headers => {
                                       :content_type  => content_type,                         
                                       :content_length => body.size.to_s
                                     },
                                     :body => body}))                                 
      end

      def extend_expire
        if @token.expired?
          @token = @token.refresh! 
        end
      end
    end
  end
end
