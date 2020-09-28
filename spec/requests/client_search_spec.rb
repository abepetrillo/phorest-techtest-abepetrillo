require "rails_helper"

RSpec.describe "Client Search", :type => :request do

  it "returns expected feedback when empty params" do
    get "/clients/search"
    expect(response.body).to include('Please enter either first name, last name or email at the top of the screen')
  end

  it "returns expected feedback on no search results" do
    get "/clients/search", params: {
      firstName: 'Does not',
      lastName: 'exist',
      email: 'captain_invisible@nowheretobeseen.com'
    }
    expect(response.body).to include('No results found')
  end

  it "returns clients that satisfy the search criteria" do
    #If preferred we could use webmock here, but if service is fairly reliable
    # I would like to do a full integration test using the real service.
    # Ideally we would create the clients via the API here and go find them
    # but in the interest of time I'm using existing data
    get "/clients/search", params: {
      firstName: '100',
      lastName: 'de'
    }
    expect(response.body).to include('100')
    expect(response.body).to include('demouk')
    expect(response.body).to include('100@demouk.com')
  end

end
