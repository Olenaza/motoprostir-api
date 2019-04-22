module MotoprostirApi
  module V1
    class Auth < BaseV1
      namespace :auth do
        params do
          requires :email, type: String, regexp: User::EMAIL_REGEXP
          requires :password, type: String
        end
        post do
          user = User.authenticate(declared_params[:email], declared_params[:password])

          if user.present?
            token = encode_payload({user_id: user.id})
            present :token, token
            present :entity, user, with: MotoprostirApi::Entities::UserEntity::Base
          else
            unauthorized! 'Incorrect email or password'
          end
        end
      end
    end
  end
end