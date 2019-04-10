module MotoprostirApi
  module V1
    class Users < BaseV1
      namespace :users do
        params do
          requires :email, type: String, regexp: User::EMAIL_REGEXP, desc: 'User email'
          requires :password, type: String, desc: 'User password'
          requires :username, type: String, desc: 'Username'
          optional :firstName, type: String, desc: 'First name'
          optional :lastName, type: String, desc: 'Last name'
          optional :gender, type: String, desc: 'Gender'
          optional :country, type: String, desc: 'Country of living'
          optional :city, type: String, desc: 'Place of living'
        end
        post do
          user = User.new(declared_params)
          if user.save
            present user
          else
            error!(user.errors.messages, 422)
          end
        end

        params do
          requires :id, type: Integer, desc: 'User id.'
        end
        route_param :id do
          desc 'Return a user.'
          get do
            User.find(params[:id])
          end

          desc 'Update a user.'
          params do
            requires :email, type: String, regexp: User::EMAIL_REGEXP, desc: 'User email'
            requires :password, type: String, desc: 'User password'
            requires :username, type: String, desc: 'Username'
            optional :firstName, type: String, desc: 'First name'
            optional :lastName, type: String, desc: 'Last name'
            optional :gender, type: String, desc: 'Gender'
            optional :country, type: String, desc: 'Country of living'
            optional :city, type: String, desc: 'Place of living'
          end
          put do
            authenticate
            forbidden! unless current_user.id == params[:id]
            if current_user.update(declared_params)
              present current_user
            else
              error!(current_user.errors.messages, 422)
            end
          end
        end
      end
    end
  end
end