require 'grape-swagger'

module MotoprostirApi
  class ApiBase < Grape::API
    default_format :json

    helpers Pundit

    mount MotoprostirApi::V1::BaseV1
  end
end
