module MotoprostirApi
  module Entities
    module EventEntity
      class Base < Grape::Entity
        expose :id
        expose :title
        expose :description
        expose :base
        expose :ride_style
        expose :speed
        expose :start_date
        expose :end_date
        expose :countries
        expose :cities
      end
    end
  end
end