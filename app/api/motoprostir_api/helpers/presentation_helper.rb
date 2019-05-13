module MotoprostirApi
  module Helpers
    module PresentationHelper
      def present_post_data(data)
        present data, with: MotoprostirApi::Entities::PostEntity::Base
      end

      def present_comment_data(data)
        present data, with: MotoprostirApi::Entities::CommentEntity::Base
      end
    end
  end
end