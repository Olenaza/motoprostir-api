module MotoprostirApi
  module V1
    class BaseV1 < MotoprostirApi::ApiBase
      extend ActionView::Helpers::TranslationHelper
      prefix 'api'
      version 'v1', using: :accept_version_header

      helpers MotoprostirApi::Helpers::MainHelper
      helpers MotoprostirApi::Helpers::AuthenticationHelper
      helpers MotoprostirApi::Helpers::AdminHelper
      helpers MotoprostirApi::Helpers::PresentationHelper
      helpers MotoprostirApi::Helpers::FollowHelper

      helpers do
        params :pagination do
          optional :page, type: Integer, desc: 'Current page number'
          optional :per_page, type: Integer, desc: 'Number of messages per page'
        end
      end

      mount Users
      mount Admin
      mount Auth
      mount Events
      mount Brands
      mount Posts
      mount Categories
      mount Relations

      add_swagger_documentation api_version: 'v1', hide_documentation_path: true
    end
  end
end