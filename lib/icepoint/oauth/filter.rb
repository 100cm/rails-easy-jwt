require "icepoint/oauth/filter/version"
require 'icepoint/oauth/model/oauth_token'
require 'icepoint/oauth/model/atyun_app'
module Icepoint
  module Oauth
    module Filter

      extend ActiveSupport::Concern

      require 'icepoint/oauth/jwt/json_web_token'

      included do

        before_filter :authenticate_request!

      end

      protected
      def authenticate_request!

        #判断token是否存在
        return render json: {message: '无效的访问令牌', code: 500} if OauthToken.where(access_token: http_token).blank?

        unless user_id_in_token? && expires_in_time?
          render json: {message: '无效的访问令牌', code: 500}, status: :unauthorized
          return
        end

        if expires_in_time? < Time.new.to_i
          render json: {message: '访问令牌过期,请重新申请访问令牌', code: 500}
          return
        end

        #保存当前调用app
        session[:current_app] = OauthApplication.find_by_sql("select * from atyun_apps as A where A.app_id + A.app_secret = '#{auth_token[:app_id]}'")

      rescue JWT::VerificationError, JWT::DecodeError
        return render json: {message: '无效的访问令牌'}, status: :unauthorized
      end

      private
      def http_token
        @http_token ||= if request.headers['Authorization'].present?
                          request.headers['Authorization'].split(' ').last
                        end
      end

      def auth_token
        @auth_token ||= JsonWebToken.decode(http_token)
      end

      def user_id_in_token?
        http_token && auth_token && auth_token[:app_id].to_i
      end

      def expires_in_time?
        http_token && auth_token && auth_token[:expires_in].to_i
      end

    end
  end
end
