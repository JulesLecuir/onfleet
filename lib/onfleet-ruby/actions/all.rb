module Onfleet
  module Actions
    module All
      module ClassMethods
        def all(filters = {})
          response = Onfleet.request(all_url_for(filters), :get)

          all_elements = []
          loop do

            # Query tasks
            response = Onfleet.request(all_url_for(filters), :get)

            # Add queried tasks to the big array
            all_elements += response["tasks"]

            # If there is no last_id, it means that there is no pagination. Go out of the loop. Else, stay here, and...
            break unless response["lastId"]

            # ... add the last id to the options sent in the request
            filters[:lastId] = response["lastId"]
          end

          all_elements.compact.map { |item| new(item) }
        end


        private


        def all_url_for(filters)
          ["#{self.api_url}/all", query_params(filters)].compact.join('?')
        end

      end


      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
