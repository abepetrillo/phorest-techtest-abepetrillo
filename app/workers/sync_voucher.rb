class SyncVoucher
  include Sidekiq::Worker


  # When given the id of a voucher in the database, the worker will
  # attempt to sync the voucher with the phorest API
  def perform(voucher_id)
    voucher = Voucher.find_by_id(voucher_id)
    if voucher
      result = PhorestGatewayService.new.create_voucher!(voucher)
      voucher.update_attributes!(
        voucher_id: result[:voucherId],
        synced_at: Time.zone.now
      )
    else
      true
    end
  end
end
