module MotoprostirApi
  module V1
    class Posts < BaseV1
      namespace :posts do
        desc 'Return all posts.'
        params do
          optional :sort_by,
                   desc: 'Sorting parameter.',
                   default: 'created_at',
                   values: %w[created_at user_id title]
          optional :user_id, type: Integer, desc: 'User id to filter posts by'
          use :pagination
        end
        get do
          if params[:user_id]
            present_post_data(Post.where(user_id: params[:user_id])
                                  .order(params[:sort_by])
                                  .page(params[:page]).per(params[:per_page]))
          else
            present_post_data(Post.order(params[:sort_by])
                                  .page(params[:page]).per(params[:per_page]))
          end
        end

        desc 'Return current user\'s posts.'
        params do
          optional :sort_by,
                   desc: 'Sorting parameter.',
                   default: 'created_at',
                   values: %w[created_at title]
          use :pagination
        end
        get :my do
          authenticate
          present_post_data(current_user.posts
                                .order(params[:sort_by])
                                .page(params[:page]).per(params[:per_page]))
        end

        params do
          requires :id, type: Integer, desc: 'Post id.'
        end
        route_param :id do
          desc 'Return a post.'
          get do
            present_post_data(Post.find(params[:id]))
          end

          desc 'Update a post.'
          params do
            optional :title, type: String, desc: 'Post title.', allow_blank: false
            optional :description, type: String, desc: 'Post text.', allow_blank: false
            optional :picture, type: String, desc: 'Url for image'
          end
          put do
            authenticate
            post = user_post
            if post.update(declared_params)
              present_post_data(post)
            else
              error!(post.errors.messages, 422)
            end
          end

          desc 'Delete a post.'
          delete do
            authenticate
            user_post.destroy
            nil
          end

          mount Comments, with: {commentable_type: 'post'}
        end

        desc 'Create a post.'
        params do
          requires :title, type: String, desc: 'Post title.', allow_blank: false
          requires :description, type: String, desc: 'Post text.', allow_blank: false
          optional :picture, type: String, desc: 'Url for image'
        end
        post do
          authenticate
          post = Post.new(declared_params.merge({user_id: current_user[:id]}))
          if post.save
            present_post_data(post)
          else
            error!(post.errors.messages, 422)
          end
        end
      end
    end
  end
end
