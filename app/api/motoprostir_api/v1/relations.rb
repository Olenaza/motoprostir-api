module MotoprostirApi
  module V1
    class Relations < BaseV1
      namespace :followers do
        desc 'Return current user followers.'
        get do
          authenticate
          present current_user.followers, with: MotoprostirApi::Entities::UserEntity::Base
        end
      end

      namespace :following do
        desc 'Return users followed by current user.'
        get do
          authenticate
          present current_user.following, with: MotoprostirApi::Entities::UserEntity::Base
        end
      end
    end
  end
end
