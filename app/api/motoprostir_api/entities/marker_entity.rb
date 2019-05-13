module MotoprostirApi
  module Entities
    module MarkerEntity
      class Base < Grape::Entity
        expose :id
        expose :lat
        expose :lng
        expose :draggable
      end
    end
  end
end