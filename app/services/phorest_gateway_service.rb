class PhorestGatewayService
  include HTTParty
  base_uri "http://api-gateway-dev.phorest.com/third-party-api-server/api/business/#{ENV.fetch('PHOREST_BUSINESS_ID')}"
  basic_auth ENV.fetch('PHOREST_USERNAME'), ENV.fetch('PHOREST_PASSWORD')
  headers 'Content-Type' => 'application/json'
  format :json

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

  #TODO: Ran out of time to fix this method but I hope this demonstrates the intention
  # Basically creates a voucher through the API and provides feedback we can save on our end which
  # is currently simulated
  def create_voucher!(voucher)
    params = {
      "clientId": voucher.client_id,
      "creatingBranchId": voucher.creating_branch_id,
      "expiryDate": "2020-10-28T11:27:49.048Z",
      "issueDate": "2020-09-28T11:27:49.048Z",
      "originalBalance": voucher.original_balance,
      "serialNumber": voucher.serial_number
    }
    #self.class.post('/voucher', body: params)
    {
      clientId: voucher.client_id,
      voucherId: SecureRandom.uuid
    }
  end

end
