module MotoprostirApi
  module V1
    class Users < BaseV1
      namespace :users do
        params do
          requires :user, type: Hash do
            requires :email, type: String, regexp: User::EMAIL_REGEXP
            requires :password, type: String
            requires :username
            optional :firstName
            optional :lastName
            optional :gender
            optional :country
            optional :city
            optional :admin, type: Boolean, desc: 'Admin flag', default: false
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