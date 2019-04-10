module MotoprostirApi
  module Helpers
    module AdminHelper
      def authorize_admin
        forbidden! unless admin?
      end

      def admin?
        authenticate
        current_user.attributes['admin']
      end
    end
  end
end