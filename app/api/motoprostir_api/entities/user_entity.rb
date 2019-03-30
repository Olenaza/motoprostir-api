module MotoprostirApi
  module Entities
    module UserEntity
      class Base < Grape::Entity
        expose :id
        expose :email
        expose :created_at
      end
    end
  end
end