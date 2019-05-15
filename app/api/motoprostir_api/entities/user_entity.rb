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

      class UserProfilePublic < Base
        expose :firstName
        expose :lastName
        expose :email
        expose :gender
        expose :country
        expose :city
        expose :created_at
        expose :updated_at
        expose :cover
        expose :followed do |_, options|
          options[:followed]
        end
      end
    end
  end
end