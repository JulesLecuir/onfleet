module Onfleet
  module Actions
    module Get
      module ClassMethods
        def get(id, filters = {})
          response = Onfleet.request(get_url_for(id, filters), :get)
          Util.constantize(name).new(response)
        end

        private

        def get_url_for(id, filters)
          ["#{self.api_url}/#{id}", query_params(filters)].compact.join('?')
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end

