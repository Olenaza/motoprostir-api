module MotoprostirApi
  module V1
    class Markers < BaseV1
      namespace :markers do
        desc "Return all markers for the event."
        get do
          event = Event.find(params[:id])
          present event.markers
        end

        params do
          requires :marker_id, type: Integer, desc: 'Marker id.'
        end
        route_param :marker_id do
          desc 'Return a marker.'
          get do
            event = Event.find(params[:id])
            event.markers.find(params[:marker_id])
          end

          desc 'Update a marker.'
          params do
            optional :lat, type: Float, desc: 'Latitude.'
            optional :lng, type: Float, desc: 'Longitude.'
            optional :draggable, type: Boolean, desc: 'Draggable property'
          end
          put do
            authenticate
            marker = user_marker
            if marker.update(declared(params, include_parent_namespaces: false))
              present marker
            else
              error!(marker.errors.messages, 422)
            end
          end

          desc 'Delete a marker.'
          delete do
            authenticate
            user_marker.destroy
            nil
          end
        end

        desc 'Create a marker.'
        params do
          requires :lat, type: Float, desc: 'Latitude.', allow_blank: false
          requires :lng, type: Float, desc: 'Longitude.', allow_blank: false
          optional :draggable, type: Boolean, desc: 'Draggable property', default: false
        end
        post do
          authenticate
          marker = Marker.new(declared_params.merge({event_id: params[:id]}))
          if marker.save
            present marker
          else
            error!(marker.errors.messages, 422)
          end
        end
      end
    end
  end
end
