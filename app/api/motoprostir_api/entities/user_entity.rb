module MotoprostirApi
  module Entities
    module UserEntity
      class Base < Grape::Entity
        expose :id
        expose :email
        expose :admin
        expose :created_at
      end
    end
  end
end