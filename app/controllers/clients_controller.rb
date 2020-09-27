class ClientsController < ApplicationController
  def search
    # Make sure at least one field is filled in
    if search_params.to_h.select {|key, value| value.present? }.count < 1
      @empty_search = true
      @clients = []
    else
      @empty_search = false
      @search = OpenStruct.new(params)
      @clients = PhorestGatewayService.new.clients(search_params.to_h)
    end

  end

  def search_params
    params.permit(:firstName, :lastName, :email)
  end
end
