class AddSyncedAtFlagToVouchers < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :voucher_id, :string
    add_column :vouchers, :synced_at, :datetime
  end
end
