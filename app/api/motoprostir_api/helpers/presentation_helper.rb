module MotoprostirApi
  module Helpers
    module PresentationHelper
      def present_post_data(data)
        present data, with: MotoprostirApi::Entities::PostEntity::Base
      end
    end
  end
end