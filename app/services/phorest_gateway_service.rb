class PhorestGatewayService
  include HTTParty
  base_uri "http://api-gateway-dev.phorest.com/third-party-api-server/api/business/#{ENV.fetch('PHOREST_BUSINESS_ID')}"
  basic_auth ENV.fetch('PHOREST_USERNAME'), ENV.fetch('PHOREST_PASSWORD')


  # Supports searching for clients, and cleans params where necessary.
  # For example the API treats empty strings as a valid search argument, so we filter those to be null
  def clients(params = {})
    params.reject! {|key, value| value.empty? }
    params.map {|key, value| params[key] = "~#{value}%"  }
    response = self.class.get('/client', {query: params})
    response = JSON.parse(response.body, symbolize_names: true)
    if response[:page][:totalElements] < 1
      []
    else
      response[:_embedded][:clients]
    end
  end

end
