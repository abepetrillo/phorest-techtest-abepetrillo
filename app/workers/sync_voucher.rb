class SyncVoucher
  include Sidekiq::Worker


  # When given the id of a voucher in the database, the worker will
  # attempt to sync the voucher with the phorest API
  def perform(voucher_id)
    voucher = Voucher.find(voucher_id)

    result = PhorestGatewayService.new.create_voucher!(voucher)
    voucher.udpate_attributes!(
      voucher_id: result[:voucherId],
      synced_at: Time.curent
    )
  end
end
