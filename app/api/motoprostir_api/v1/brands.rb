module MotoprostirApi
  module V1
    class Brands < BaseV1
      prefix 'motorcycle'
      namespace :brands do
        desc 'Returns all bike brands.'
        get do
          present Brand.all.order(:name)
        end

        params do
          requires :id, type: Integer, desc: 'Brand id.'
        end
        route_param :id do
          desc 'Return a bike brand.'
          get do
            Brand.find(params[:id])
          end

          desc 'Update a bike brand.'
          params do
            requires :name, type: String, desc: 'Brand name.', allow_blank: false
          end
          put do
            authorize_admin
            brand = Brand.find(params[:id])
            if brand.update(declared_params)
              present brand
            else
              error!(brand.errors.messages, 422)
            end
          end

          desc 'Delete a bike brand.'
          delete do
            authorize_admin
            Brand.find(params[:id]).destroy
            nil
          end
        end

        desc 'Create a bike brand.'
        params do
          requires :name, type: String, desc: 'Brand name.', allow_blank: false
        end
        post do
          authorize_admin
          brand = Brand.new(declared_params)
          if brand.save
            present brand
          else
            error!(brand.errors.messages, 422)
          end
        end
      end
    end
  end
end