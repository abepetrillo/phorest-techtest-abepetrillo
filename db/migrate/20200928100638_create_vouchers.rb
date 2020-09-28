class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.string :client_id, null: false
      t.string :creating_branch_id, null: false
      t.timestamp :expiry_date
      t.timestamp :issue_date
      t.integer :original_balance, null: false
      t.string :serial_number

      t.timestamps
    end
  end
end
