require 'net/https'

class ServiceController < ApplicationController
  def list_restaurants
    latitude = params[:latitude]
    longitude = params[:longitude]

    if user_signed_in? && (latitude && longitude)
      path = "/maps/api/place/search/json"
      query = { location: "#{latitude},#{longitude}",
                radius:   500,
                types:     'food',
                language: 'ja',
                sensor:   true }
      response = proxy_google path, query
    end

    if response
      if response.code.to_i < 400
        render json: response.body
      else
        render json: '', status: response.code.to_i
      end
    else
      render json: '', status: 401 # unauthorized
    end
  end

  def show_restaurant
    reference = params[:reference]

    if user_signed_in? && reference
      path = "/maps/api/place/details/json"
      query = { reference: reference,
                language:  'ja',
                sensor:    true }
      response = proxy_google path, query
    end

    if response
      if response.code.to_i < 400
        render json: response.body
      else
        render json: '', status: response.code.to_i
      end
    else
      render json: '', status: 401 # unauthorized
    end
  end

  private
  def proxy_google(path, query_hash)
    host = "maps.googleapis.com"
    port = 443

    query_hash[:key] = Mychelin::Application.config.google_api_key

    https = if ENV['https_proxy'].present?
              u = URI.parse(ENV['http_proxy'])
              Net::HTTP::Proxy(u.host, u.port)
            else
              Net::HTTP
            end
    https = https.new(host, port)
    https.use_ssl = true

    https.start do |h|
      h.get(path + '?' + query_hash.to_query)
    end
  end
end
