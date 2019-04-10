module MotoprostirApi
  module Helpers
    module AuthenticationHelper
      include MotoprostirApi::Helpers::MainHelper

      def current_user
        @current_user
      end

      def unauthorized!(error_message)
        formatted_error!(401, :Unauthorized, error_message)
      end

      def encode_payload(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
      end

      def authenticate
        @current_user = User.find(decoded_token.try(:dig, :user_id))
      rescue ActiveRecord::RecordNotFound
        unauthorized! 'Invalid token'
      end

      def decoded_token
        JWT.decode(
            token,
            Rails.application.credentials.secret_key_base,
            true,
            algorithm: 'HS256'
        )&.first&.with_indifferent_access
      rescue JWT::DecodeError
        nil
      end

      def token
        if headers['Authorization'].present?
          return headers['Authorization'].split(' ').last
        end
        unauthorized!'Missing token'
      end
    end
  end
end