module MotoprostirApi
  module Entities
    module CommentEntity
      class Base < Grape::Entity
        expose :id
        expose :text
        expose :created_at
        expose :updated_at
        expose :user, using: UserEntity::Base
      end
    end
  end
end
