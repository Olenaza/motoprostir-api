Rails.application.routes.draw do
  mount MotoprostirApi::ApiBase => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
