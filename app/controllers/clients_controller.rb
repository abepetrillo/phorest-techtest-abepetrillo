class ClientsController < ApplicationController
  def search
    @clients = PhorestGatewayService.new.clients || []
  end
end
