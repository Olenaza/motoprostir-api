module MotoprostirApi
  module V1
    class Admin < BaseV1
      namespace :admin do
        namespace :users do
          desc 'Return all users.'
          params do
            optional :sort_by,
                     desc: 'Optional sorting parameter.',
                     default: 'username',
                     values: %w[username created_at updated_at country city]
            use :pagination
          end
          get do
            authorize_admin
            present User.order(params[:sort_by]).page(params[:page]).per(params[:per_page])
          end

          params do
            requires :id, type: Integer, desc: 'User id.'
          end
          route_param :id do
            desc 'Update user status.'
            params do
              requires :admin, type: Boolean, desc: 'Admin flag'
            end
            put do
              authorize_admin
              user = User.find(params[:id])
              if user.update(declared_params)
                present user
              else
                error!(user.errors.messages, 422)
              end
            end
          end
        end
      end
    end
  end
end