class ClientsController < ApplicationController
  def search
    # Make sure at least one field is filled in
    if search_params.to_h.select {|key, value| value.present? }.count < 1
      @empty_search = true
      @clients = []
    else
      @empty_search = false
      # used to populate the search form
      @search = OpenStruct.new(params)
      @result = PhorestGatewayService.new.clients(search_params.to_h)
      @clients = @result[:clients]
      @page = @result[:page]
      # Page index starts at zero, but we want to show the first page as 1
      @current_page_number = (@page[:number] || 0) + 1
    end
    render :search, locals: {search_params: search_params}
  end

  def show
    @client = PhorestGatewayService.new.client(params[:id])
  end

  private

  def search_params
    params.permit(:firstName, :lastName, :email, :page)
  end
end
