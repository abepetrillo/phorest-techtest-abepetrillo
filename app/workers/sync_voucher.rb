class SyncVoucher
  include Sidekiq::Worker


  # When given the id of a voucher in the database, the worker will
  # attempt to sync the voucher with the phorest API
  def perform(voucher_id)
    
  end
end
