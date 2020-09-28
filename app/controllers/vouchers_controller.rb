class VouchersController < ApplicationController
  def new
    @voucher = Voucher.new(client_id: params[:client_id])
  end

  # Creates a voucher that is saved in our database.
  # Also handles the responsibility of triggering the async update
  # to the phorest API. Should the responsibilties of the controller grow
  # we can break this logic out into a service.
  def create
    automated_params = {
      creating_branch_id: ENV.fetch('PHOREST_BRANCH_ID'),
      serial_number: "in-branch-#{SecureRandom.uuid}"
    }
    @voucher = Voucher.create(voucher_params.merge(automated_params))
    if @voucher.valid?
      SyncVoucher.perform_async(@voucher.id)
      redirect_to voucher_path(@voucher)
    else
      render :new
    end
  end

  def index
    @vouchers = Voucher.all
  end

  def show
    @voucher = Voucher.find(params[:id])
  end

  private

  def voucher_params
    params.require(:voucher).permit(:expiry_date, :issue_date, :original_balance_in_euros, :client_id)
  end
end
