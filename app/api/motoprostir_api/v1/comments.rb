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
            requires :text, type: String, desc: 'Comment text.', allow_blank: false
          end
          put do
            authenticate
            comment = user_comment
            if comment.update(declared_params)
              present comment
            else
              error!(comment.errors.messages, 422)
            end
          end

          desc 'Delete a comment.'
          delete do
            authenticate
            user_comment.destroy
          end
        end

        desc 'Create a comment.'
        params do
          requires :commentable_type, type: String, desc: 'Commentable entity type'
          requires :commentable_id, type: Integer, desc: 'Commentable entity id'
          requires :text, type: String, desc: 'Comment text.', allow_blank: false
        end
        post do
          authenticate
          comment = Comment.new(declared_params.merge({user_id: current_user[:id]}))
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