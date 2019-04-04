module MotoprostirApi
  module Helpers
    module MainHelper
      def declared_params
        @params ||= declared(params, include_missing: false)
      end

      def formatted_error!(code, status, message)
        message = {
          status_code: status,
          message: message
        }
        error!(message, code)
      end

      def user_event
        current_user.events.find(params[:id])
      end

      def user_comment
        current_user.comments.find(params[:id])
      end

      def user_post
        current_user.posts.find(params[:id])
      end

      def forbidden!
        formatted_error!(403, :Forbidden, 'Permission denied')
      end
    end
  end
end