module MotoprostirApi
  module V1
    class Posts < BaseV1
      namespace :posts do
        desc 'Return all posts.'
        params do
          optional :sort_by,
                   desc: 'Optional sorting parameter.',
                   default: 'created_at',
                   values: %w[created_at user_id title]
          use :pagination
        end
        get do
          present Post.order(params[:sort_by]).page(params[:page]).per(params[:per_page])
        end

        desc 'Return user\'s posts.'
        params do
          optional :sort_by,
                   desc: 'Optional sorting parameter.',
                   default: 'created_at',
                   values: %w[created_at title]
          use :pagination
        end
        get :my do
          authenticate
          current_user.posts.order(params[:sort_by]).page(params[:page]).per(params[:per_page])
        end

        params do
          requires :id, type: Integer, desc: 'Post id.'
        end
        route_param :id do
          desc 'Return a post.'
          get do
            Post.find(params[:id])
          end

          desc 'Returns all comments for the post.'
          params do
            use :pagination
          end
          get 'comments' do
            present Post.find(params[:id]).comments.order(:created_at).page(params[:page]).per(params[:per_page])
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
              present post
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
        end

        desc 'Create a post.'
        params do
          requires :title, type: String, desc: 'Post title.', allow_blank: false
          requires :description, type: String, desc: 'Post text.', allow_blank: false
          optional :picture, type: String, desc: 'Cover picture'
        end
        post do
          authenticate
          post = Post.new(declared_params.merge({user_id: current_user[:id]}))
          if post.save
            present post
          else
            error!(post.errors.messages, 422)
          end
        end
      end
    end
  end
end
