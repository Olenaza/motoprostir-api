module MotoprostirApi
  module Entities
    module PostEntity
      class Base < Grape::Entity
        expose :id
        expose :title
        expose :description
        expose :created_at
        expose :user_id
      end
    end
  end
end