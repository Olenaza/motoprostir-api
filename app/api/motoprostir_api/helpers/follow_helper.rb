module MotoprostirApi
  module Helpers
    module FollowHelper
      def following?(user)
        authenticate
        current_user.following.include?(user)
      end
    end
  end
end