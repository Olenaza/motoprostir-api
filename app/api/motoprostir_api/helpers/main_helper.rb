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
        event = Event.find(params[:id])
        forbidden! unless current_user.id == event.user_id
        event
      end

      def user_comment
        comment = Comment.find(params[:comment_id])
        forbidden! unless current_user.id == comment.user_id
        comment
      end

      def user_post
        post = Post.find(params[:id])
        forbidden! unless current_user.id == post.user_id
        post
      end

      def forbidden!
        formatted_error!(403, :Forbidden, 'Permission denied')
      end
    end
  end
end