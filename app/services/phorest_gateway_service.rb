class PhorestGatewayService
  include HTTParty
  base_uri "http://api-gateway-dev.phorest.com/third-party-api-server/api/business/#{ENV.fetch('PHOREST_BUSINESS_ID')}"
  basic_auth ENV.fetch('PHOREST_USERNAME'), ENV.fetch('PHOREST_PASSWORD')


  def clients
    response = self.class.get('/client', {query: {firstName: '~pro%', email: '~de%'}})
    JSON.parse(response.body, symbolize_names: true).first[1][:clients]
  end

end
