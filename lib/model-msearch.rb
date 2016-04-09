module Elasticsearch
  module Model
    module ClassMethods
      def msearch!(payload)
        # Extract the search body.
        body = payload.map do |source|
          __index_name    = source.klass.index_name
          __document_type = source.klass.document_type

          # Extract the actual body from each search source.
          [{index: __index_name, type: __document_type},
           source.search.definition[:body]]
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
