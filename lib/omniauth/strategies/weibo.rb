require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Weibo < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site           => "https://api.weibo.com",
        :authorize_url  => "/oauth2/authorize",
        :token_url      => "/oauth2/access_token"
      }
      option :token_params, {
        :parse          => :json
      }

      uid do
        raw_info['id']
      end

      info do
        {
          :nickname     => raw_info['screen_name'],
          :name         => raw_info['name'],
          :location     => raw_info['location'],
          :image        => raw_info['profile_image_url'],
          :description  => raw_info['description'],
          :urls => {
            'Blog'      => raw_info['url'],
            'Weibo'     => raw_info['domain'].present?? "http://weibo.com/#{raw_info['domain']}" : "http://weibo.com/u/#{raw_info['id']}",
          }
        }
      end

      extra do
        {
          :raw_info => raw_info
        }
      end

      def raw_info
        access_token.options[:mode] = :query
        access_token.options[:param_name] = 'access_token'
        @uid ||= access_token.get('/2/account/get_uid.json').parsed["uid"]
        @raw_info ||= access_token.get("/2/users/show.json", :params => {:uid => @uid}).parsed
      end

      ##
      # You can pass +display+, +with_offical_account+ or +state+ params to the auth request, if
      # you need to set them dynamically. You can also set these options
      # in the OmniAuth config :authorize_params option.
      #
      # /auth/weibo?display=mobile&with_offical_account=1
      #
      def authorize_params
        super.tap do |params|
          %w[display with_offical_account state forcelogin].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]

              # to support omniauth-oauth2's auto csrf protection
              session['omniauth.state'] = params[:state] if v == 'state'
            end
          end
        end
      end
      
    end
  end
end

OmniAuth.config.add_camelization "weibo", "Weibo"
