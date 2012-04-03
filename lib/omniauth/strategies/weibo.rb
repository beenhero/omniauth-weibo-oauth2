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
      
      alias :old_request_phase :request_phase
      def request_phase
        display = session['omniauth.params']['display']
        if display
          options[:authorize_params].merge!(:display => display)
        end
        old_request_phase
      end
      
    end
  end
end

OmniAuth.config.add_camelization "weibo", "Weibo"
