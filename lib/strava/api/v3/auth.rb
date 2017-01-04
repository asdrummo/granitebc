require 'httmultiparty'

module Strava::Api::V3
  class Auth
    # Fetch user access token
    #
    # See {http://strava.github.io/api/v3/oauth} for full details
    #
    # @param client_id
    # @param client_secret
    # @param code
    #
    # @return access_token + athlete json (see http://strava.github.io/api/v3/oauth/#token-exchange)
    def self.retrieve_access(client_id, client_secret, code)
      args = {
        client_id: client_id,
        client_secret: client_secret,
        code: code
      }

      HTTMultiParty.public_send(
        'post',
        Strava::Api::V3::Configuration::DEFAULT_AUTH_ENDPOINT,
        query: args
      )
    end
  end
end
