module MotoprostirApi
  module V1
    class Users < BaseV1
      namespace :users do
        params do
          requires :user, type: Hash do
            requires :email, type: String, regexp: User::EMAIL_REGEXP
            requires :password, type: String
            requires :username
            requires :firstName
            requires :lastName
            requires :gender
            requires :country
            requires :city
            requires :admin, type: Boolean, desc: 'Admin flag'
          end
        end
        post do
          entity = User.new(declared_params[:user])

          if entity.save
            present :entity, entity
          else
            error!(entity.errors.messages, 422)
          end
        end
      end
    end
  end
end