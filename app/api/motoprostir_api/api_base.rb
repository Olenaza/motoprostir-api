require 'grape-swagger'

module MotoprostirApi
  class ApiBase < Grape::API
    default_format :json

    helpers Pundit

    rescue_from ActiveRecord::RecordNotFound do |e|
      formatted_error!(404, 'Not Found', e.to_s)
    end

    mount MotoprostirApi::V1::BaseV1
  end
end
