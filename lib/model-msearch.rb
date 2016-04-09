module Elasticsearch
  module Model
    module ClassMethods
      MSEARCH_VALID_HEADERS = [:index, :type, :search_type, :preference, :routing]

      def msearch!(payload)
        # Extract the search body.
        body = payload.map do |source|
          # Reformat the search definition into something Elastic will accept.
          __headers = source.search.definition.slice(*MSEARCH_VALID_HEADERS)
          __definition = source.search.definition.except(*MSEARCH_VALID_HEADERS)
          __body = __definition.delete(:body)

          [__headers, __definition.merge(__body)]
        end

        # Elasticsearch expects the body to be sent in header\nbody format.
        # Client#msearch automatically does this when passing an array.
        body.flatten!
        results = client.msearch(body: body)

        # Return an array of loaded Responses.
        responses = []
        results["responses"].each_with_index do |result, i|
          r = Response::Response.new(payload[i].klass, payload[i].search)
          # 10/10 encapsulation
          r.instance_variable_set(:@response, Hashie::Mash.new(result))
          responses.push r
        end
        responses
      end
    end
  end
end
