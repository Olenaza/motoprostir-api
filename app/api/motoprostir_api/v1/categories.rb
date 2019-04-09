module MotoprostirApi
  module V1
    class Categories < BaseV1
      namespace :categories do
        desc 'Returns all post categories.'
        get do
          present Category.all.order(:name)
        end

        params do
          requires :id, type: Integer, desc: 'Category id.'
        end
        route_param :id do
          desc 'Return a category.'
          get do
            Category.find(params[:id])
          end

          desc 'Update a category.'
          params do
            requires :name, type: String, desc: 'Category name.', allow_blank: false
          end
          put do
            authorize_admin
            category = Category.find(params[:id]).update(declared_params)
            if category
              present category
            else
              error!(category.errors.messages, 422)
            end
          end

          desc 'Delete a category.'
          delete do
            authorize_admin
            Category.find(params[:id]).destroy
          end
        end

        desc 'Create a category.'
        params do
          requires :name, type: String, desc: 'Category name.', allow_blank: false
        end
        post do
          authorize_admin
          category = Category.new(declared_params)
          if category.save
            present category
          else
            error!(category.errors.messages, 422)
          end
        end
      end
    end
  end
end