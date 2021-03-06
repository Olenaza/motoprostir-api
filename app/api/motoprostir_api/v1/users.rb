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
          optional :avatar, type: String, desc: 'Url for avatar image'
          optional :cover, type: String, desc: 'Url for cover image'
        end
        post do
          user = User.new(declared_params)
          if user.save
            present user, with: MotoprostirApi::Entities::UserEntity::UserProfile
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
            user = User.find(params[:id])
            present user,
                    with: MotoprostirApi::Entities::UserEntity::UserProfilePublic,
                    followed: following?(user)
          end

          desc 'Update a user.'
          params do
            optional :email, type: String, regexp: User::EMAIL_REGEXP, desc: 'User email'
            optional :password, type: String, desc: 'User password'
            optional :username, type: String, desc: 'Username'
            optional :firstName, type: String, desc: 'First name'
            optional :lastName, type: String, desc: 'Last name'
            optional :gender, type: String, desc: 'Gender'
            optional :country, type: String, desc: 'Country of living'
            optional :city, type: String, desc: 'Place of living'
            optional :avatar, type: String, desc: 'Url for avatar image'
            optional :cover, type: String, desc: 'Url for cover image'
          end
          put do
            authenticate
            forbidden! unless current_user.id == params[:id]
            if current_user.update(declared_params)
              present current_user, with: MotoprostirApi::Entities::UserEntity::UserProfile
            else
              error!(current_user.errors.messages, 422)
            end
          end

          desc 'Return users followed by a user.'
          get :following do
            user = User.find(params[:id])
            present user.following, with: MotoprostirApi::Entities::UserEntity::Base
          end

          desc 'Return user\'s followers.'
          get :followers do
            user = User.find(params[:id])
            present user.followers, with: MotoprostirApi::Entities::UserEntity::Base
          end

          desc 'Get presigned url for file upload to S3'
          params do
            requires :file_name,
                     type: String, regexp: User::FILENAME_REGEXP,
                     desc: 'File name. Allowed extensions are png, jpg, jpeg, gif'
          end
          get :presigned_url do
            authenticate
            s3_resource = Aws::S3::Resource::new(region: ENV.fetch("AWS_REGION"))
            object = s3_resource.bucket(ENV.fetch("S3_BUCKET")).object(params[:file_name])
            signed_url = object.presigned_url(:put, expires_in: 1.minutes.to_i, acl: 'public-read')

            present signed_url
          end

          desc 'Follow a user.'
          post :follow do
            authenticate
            user = User.find(params[:id])
            if current_user.follow(user.id)
              present :following_user, user, with: MotoprostirApi::Entities::UserEntity::Base
            else
              error!('Unable to follow user.', 422)
            end
          end

          desc 'Unfollow a user.'
          post :unfollow do
            authenticate
            user = User.find(params[:id])
            current_user.unfollow(user.id)
            return_no_content
          end
        end
      end
    end
  end
end