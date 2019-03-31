module MotoprostirApi
  module Entities
    module BrandEntity
      class Base < Grape::Entity
        expose :id
        expose :name
      end
    end
  end
end
