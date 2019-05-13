module MotoprostirApi
  module V1
    class Comments < BaseV1
      namespace :comments do
        commentable_type = configuration[:commentable_type]

        desc "Returns all comments for the #{commentable_type}."
        params do
          use :pagination
        end
        get do
          if commentable_type == 'post'
            comments = Post.find(params[:id]).comments
          else
            comments = Event.find(params[:id]).comments
          end
          present comments.order(:created_at).page(params[:page]).per(params[:per_page])
        end

        params do
          requires :comment_id, type: Integer, desc: 'Comment id.'
        end
        route_param :comment_id do
          desc 'Update a comment.'
          params do
            requires :text, type: String, desc: 'Comment text.', allow_blank: false
          end
          put do
            authenticate
            comment = user_comment
            if comment.update(declared(params, include_parent_namespaces: false))
              present comment
            else
              error!(comment.errors.messages, 422)
            end
          end

          desc 'Delete a comment.'
          delete do
            authenticate
            user_comment.destroy
            nil
          end
        end

        desc 'Create a comment.'
        params do
          requires :text, type: String, desc: 'Comment text.', allow_blank: false
        end
        post do
          authenticate
          comment = Comment.new(declared(params, include_parent_namespaces: false).merge({
            user_id: current_user[:id],
            commentable_type: commentable_type.to_s.camelize,
            commentable_id: params[:id]
          }))
          if comment.save
            present comment
          else
            error!(comment.errors.messages, 422)
          end
        end
      end
    end
  end
end