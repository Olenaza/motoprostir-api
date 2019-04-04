module MotoprostirApi
  module Entities
    module PostEntity
      class Base < Grape::Entity
        expose :id
        expose :title
        expose :description
      end
    end
  end
end