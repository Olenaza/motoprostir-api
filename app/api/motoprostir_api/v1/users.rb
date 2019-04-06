module MotoprostirApi
  module V1
    class Users < BaseV1
      namespace :users do
        params do
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
        post do
          user = User.new(declared_params)

          if user.save
            present user
          else
            error!(user.errors.messages, 422)
          end
        end
      end
    end
  end
end