# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

module Elasticsearch
  module API
    module Actions
      # Allows to evaluate the quality of ranked search results over a set of typical search queries
      #
      # @option arguments [List] :index A comma-separated list of index names to search; use `_all` or empty string to perform the operation on all indices
      # @option arguments [Boolean] :ignore_unavailable Whether specified concrete indices should be ignored when unavailable (missing or closed)
      # @option arguments [Boolean] :allow_no_indices Whether to ignore if a wildcard indices expression resolves into no concrete indices. (This includes `_all` string or when no indices have been specified)
      # @option arguments [String] :expand_wildcards Whether to expand wildcard expression to concrete indices that are open, closed or both.
      #   (options: open,closed,hidden,none,all)

      # @option arguments [String] :search_type Search operation type
      #   (options: query_then_fetch,dfs_query_then_fetch)

      # @option arguments [Hash] :headers Custom HTTP headers
      # @option arguments [Hash] :body The ranking evaluation search definition, including search requests, document ratings and ranking metric definition. (*Required*)
      #
      # @see https://www.elastic.co/guide/en/elasticsearch/reference/7.7/search-rank-eval.html
      #
      def rank_eval(arguments = {})
        raise ArgumentError, "Required argument 'body' missing" unless arguments[:body]

        headers = arguments.delete(:headers) || {}

        arguments = arguments.clone

        _index = arguments.delete(:index)

        method = Elasticsearch::API::HTTP_GET
        path   = if _index
                   "#{Utils.__listify(_index)}/_rank_eval"
                 else
                   "_rank_eval"
  end
        params = Utils.__validate_and_extract_params arguments, ParamsRegistry.get(__method__)

        body = arguments[:body]
        perform_request(method, path, params, body, headers).body
      end

      # Register this action with its valid params when the module is loaded.
      #
      # @since 6.2.0
      ParamsRegistry.register(:rank_eval, [
        :ignore_unavailable,
        :allow_no_indices,
        :expand_wildcards,
        :search_type
      ].freeze)
    end
    end
end
