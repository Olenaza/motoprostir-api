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
            requires :title, type: String, desc: 'Event title.', allow_blank: false
            requires :ride_style, type: String, desc: 'Expected ride style.', allow_blank: false
            requires :speed, type: Integer, desc: 'Expected speed.', values: 40..300
            with type: Date, coerce_with: ->(val) { Date.parse(val) } do
              requires :start_date, desc: 'Expected start date.'
              requires :end_date, desc: 'Expected end date.'
            end
            with type: Array[String], coerce_with: ->(val) { val.split(/\s+/) } do
              requires :countries, desc: 'Countries to visit.'
              requires :cities, desc: 'Cities to visit.'
            end
            optional :picture, type: File, desc: 'Cover picture'
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
        end

        desc 'Create an event.'
        params do
          requires :title, type: String, desc: 'Event title.', allow_blank: false
          requires :ride_style, type: String, desc: 'Expected ride style.', allow_blank: false
          requires :speed, type: Integer, desc: 'Expected speed.', values: 40..300
          with type: Date, coerce_with: ->(val) { Date.parse(val) } do
            requires :start_date, desc: 'Expected start date.'
            requires :end_date, desc: 'Expected end date.'
          end
          with type: Array[String], coerce_with: ->(val) { val.split(/,/) } do
            requires :countries, desc: 'Countries to visit.'
            requires :cities, desc: 'Cities to visit.'
          end
          optional :picture, type: File, desc: 'Cover picture'
        end
        post do
          authenticate

          # params[:avatar][:tempfile] # => #<File>
          # params[:picture][:filename] # => 'avatar.png'
          # params[:picture][:type] # => 'image/png'
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