module MotoprostirApi
  module Entities
    module CommentEntity
      class Base < Grape::Entity
        expose :id
        expose :text
        expose :commentable_type
        expose :commentable_id
        expose :user_id
        expose :created_at
        expose :updated_at
      end
    end
  end
end
