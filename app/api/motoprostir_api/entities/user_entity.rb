module MotoprostirApi
  module Entities
    module UserEntity
      class Base < Grape::Entity
        expose :id
        expose :username
        expose :avatar
      end

      class UserProfile < Base
        expose :firstName
        expose :lastName
        expose :email
        expose :gender
        expose :country
        expose :city
        expose :admin
        expose :created_at
        expose :updated_at
        expose :cover
      end
    end
  end
end