module MotoprostirApi
  module Helpers
    module AdminHelper
      def authorize_admin
        forbidden! unless is_admin?
      end

      def is_admin?
        authorize_request

        current_user.attributes['admin']
      end
    end
  end
end