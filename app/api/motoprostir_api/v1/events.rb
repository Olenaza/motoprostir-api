module MotoprostirApi
  module V1
    class Events < BaseV1
      namespace :events do
        desc 'Return all events.'
        params do
          optional :sort_by,
                   desc: 'Optional sorting parameter.',
                   default: 'created_at',
                   values: %w[created_at user_id title ride_style start_date]
          use :pagination
        end
        get do
          present Event.order(params[:sort_by]).page(params[:page]).per(params[:per_page])
        end

        desc 'Return user\'s events.'
        params do
          optional :sort_by,
                   desc: 'Optional sorting parameter.',
                   default: 'created_at',
                   values: %w[created_at title ride_style start_date]
          use :pagination
        end
        get :my do
          authenticate
          current_user.events.order(params[:sort_by]).page(params[:page]).per(params[:per_page])
        end

        params do
          requires :id, type: Integer, desc: 'Event id.'
        end
        route_param :id do
          desc 'Return an event.'
          get do
            Event.find(params[:id])
          end

          desc 'Returns all comments for the event.'
          params do
            use :pagination
          end
          get 'comments' do
            present Event.find(params[:id]).comments.order(:created_at).page(params[:page]).per(params[:per_page])
          end

          desc 'Update an event.'
          params do
            optional :title, type: String, desc: 'Event title.', allow_blank: false
            optional :description, type: String, desc: 'Event description.', allow_blank: false
            optional :ride_style, type: String, desc: 'Expected ride style.', allow_blank: false
            optional :speed, type: Integer, desc: 'Expected speed.', values: 40..300
            optional :base, type: String, desc: 'Type of overnight stay.', allow_blank: false
            with type: Date, coerce_with: ->(val) { Date.parse(val) } do
              optional :start_date, desc: 'Expected start date.'
              optional :end_date, desc: 'Expected end date.'
            end
            with type: Array[String], coerce_with: ->(val) { val.split(/\s+/) } do
              optional :countries, desc: 'Countries to visit.'
              optional :cities, desc: 'Cities to visit.'
            end
            optional :picture, type: String, desc: 'Url for cover picture'
          end
          put do
            authenticate
            event = user_event
            if event.update(declared_params)
              present event
            else
              error!(event.errors.messages, 422)
            end
          end

          desc 'Delete an event.'
          delete do
            authenticate
            user_event.destroy
            nil
          end

          mount Comments, with: {commentable_type: 'event'}
          mount Markers
        end

        desc 'Create an event.'
        params do
          requires :title, type: String, desc: 'Event title.', allow_blank: false
          requires :description, type: String, desc: 'Event description.', allow_blank: false
          requires :ride_style, type: String, desc: 'Expected ride style.', allow_blank: false
          requires :speed, type: Integer, desc: 'Expected speed.', values: 40..300
          optional :base, type: String, desc: 'Type of overnight stay.', allow_blank: false
          with type: Date, coerce_with: ->(val) { Date.parse(val) } do
            requires :start_date, desc: 'Expected start date.'
            requires :end_date, desc: 'Expected end date.'
          end
          with type: Array[String], coerce_with: ->(val) { val.split(/,/) } do
            optional :countries, desc: 'Countries to visit.'
            optional :cities, desc: 'Cities to visit.'
          end
          optional :picture, type: String, desc: 'Url for cover picture'
        end
        post do
          authenticate
          event = Event.new(declared_params.merge({user_id: current_user[:id]}))
          if event.save
            present event
          else
            error!(event.errors.messages, 422)
          end
        end
      end
    end
  end
end