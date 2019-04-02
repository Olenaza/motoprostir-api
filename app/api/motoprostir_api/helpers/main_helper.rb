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
        begin
          current_user.events.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          formatted_error!(404, 'Not Found', e.to_s)
        end
      end

      def user_comment
        begin
          current_user.comments.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          formatted_error!(404, 'Not Found', e.to_s)
        end
      end

      def forbidden!
        formatted_error!(403, :Forbidden, 'Permission denied')
      end
    end
  end
end