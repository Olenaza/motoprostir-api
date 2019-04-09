module MotoprostirApi
  module Entities
    module CategoryEntity
      class Base < Grape::Entity
        expose :id
        expose :name
      end
    end
  end
end
