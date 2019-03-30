module MotoprostirApi
  module V1
    class Comments < BaseV1
      namespace :comments do
        params do
          requires :id, type: Integer, desc: 'Comment id.'
        end
        route_param :id do
          desc 'Update a comment.'
          params do
            requires :comment, type: Hash do
              requires :text, type: String, desc: 'Comment text.', allow_blank: false
            end
          end
          put do
            authorize_request

            comment = user_comment.update(params[:text])

            if comment
              present :comment, comment
            else
              error!(comment.errors.messages, 422)
            end
          end

          desc 'Delete a comment.'
          delete do
            authorize_request

            current_user.comments.find(params[:id]).destroy
          end
        end

        desc 'Create a comment.'
        params do
          requires :comment, type: Hash do
            requires :user_id, type: Integer, desc: 'Author id.'
            requires :commentable_type, type: String, desc: 'Commentable entity type'
            requires :commentable_id, type: Integer, desc: 'Commentable entity id'
            requires :text, type: String, desc: 'Comment text.', allow_blank: false
          end
        end
        post do
          authorize_request

          comment = Comment.new(declared_params[:comment].merge({user_id: current_user[:id]}))

          if comment.save
            present :comment, comment
          else
            error!(comment.errors.messages, 422)
          end
        end
      end
    end
  end
end