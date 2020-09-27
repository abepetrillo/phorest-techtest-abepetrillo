class ClientsController < ApplicationController
  def search
    # Make sure at least one field is filled in
    if search_params.to_h.select {|key, value| value.present? }.count < 1
      @empty_search = true
      @clients = []
    else
      @empty_search = false
      @search = OpenStruct.new(params)
      @result = PhorestGatewayService.new.clients(search_params.to_h)
      @clients = @result[:clients]
      @page = @result[:page]
    end
    render :search, locals: {search_params: search_params}
  end

  private

  def search_params
    params.permit(:firstName, :lastName, :email, :page)
  end
end
