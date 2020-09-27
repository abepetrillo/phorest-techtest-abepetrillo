class PhorestGatewayService
  include HTTParty
  base_uri "http://api-gateway-dev.phorest.com/third-party-api-server/api/business/#{ENV.fetch('PHOREST_BUSINESS_ID')}"
  basic_auth ENV.fetch('PHOREST_USERNAME'), ENV.fetch('PHOREST_PASSWORD')


  # Supports searching for clients, and cleans params where necessary.
  # For example the API treats empty strings as a valid search argument, so we filter those to be null
  def clients(params = {})
    params.reject! {|key, value| value.empty? }
    [
      :firstName, :lastName, :email
    ].map do |key|
      params[key] = "~#{params[key]}%"
    end
    response = self.class.get('/client', {query: params})
    response = JSON.parse(response.body, symbolize_names: true)
    if response[:page][:totalElements] < 1
      {clients: [], page: response[:page]}
    else
      {clients: response[:_embedded][:clients], page: response[:page]}
    end
  end

  def client(id)
    response = self.class.get("/client/#{id}")
    JSON.parse(response.body, symbolize_names: true)
  end

end
