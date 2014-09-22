require 'newegg/version'
require 'faraday'
require 'newegg/response/parse_json'
require 'newegg/api'

module Newegg
  # API Client
  class Client
    include Newegg::API

    DEFAULT_ENDPOINT = 'https://api.newegg.cn'

    attr_reader :app_key, :access_token

    # Initializes a new Client object
    # @param options [Hash]
    # @option options [String] :app_key Required.
    # @option options [String] :access_token Required.
    # @option options [String] :endpoint Optional.
    def initialize(options)
      @app_key = options.fetch(:app_key)
      @access_token = options.fetch(:access_token)
      @endpoint = options[:endpoint]
    end

    # @return [String]
    def endpoint
      @endpoint ||= DEFAULT_ENDPOINT
    end

    # @return [String]
    def user_agent
      "Newegg Ruby Gem #{Newegg::VERSION}"
    end

    # Connection options for faraday
    #
    # @return [Hash]
    def connection_options
      {
        builder: middleware,
        headers: {
          accept: 'application/json',
          user_agent: user_agent,
          Authorization: "#{app_key}&#{access_token}"
        },
        request: {
          open_timeout: 10,
          timeout: 30
        }
      }
    end

    # @return [Faraday::RackBuilder]
    def middleware
      Faraday::RackBuilder.new do |faraday|
        # Checks for files in the payload, otherwise leaves everything untouched
        faraday.request :multipart
        # Encodes as "application/x-www-form-urlencoded" if not already encoded
        faraday.request :url_encoded
        # Parse JSON response bodies
        faraday.response :parse_json
        # Set default HTTP adapter
        faraday.adapter :net_http
      end
    end

    # Perform an HTTP GET request
    def get(path, params = {})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params = {})
      request(:post, path, params)
    end

    # Perform an HTTP PUT request
    def put(path, params = {})
      request(:put, path, params)
    end

    # Perform an HTTP DELETE request
    def delete(path, params = {})
      request(:delete, path, params)
    end

    private

    def connection
      @connection ||= Faraday.new(endpoint, connection_options)
    end

    def request(method, path, params = {}, headers = {})
      connection.send(method.to_sym, path, params) { |request| request.headers.update(headers) }.env
    end
  end
end
