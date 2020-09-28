class Voucher < ApplicationRecord
  validates_presence_of :client_id,
                        :creating_branch_id

  validates :original_balance, numericality: {only_integer: true, greater_than: 0}

  def original_balance_in_euros
    BigDecimal(original_balance || 0) / 100
  end

  #TODO: Make sure euros is only taken as two decimal places
  def original_balance_in_euros=(euros)
    self.original_balance = (BigDecimal(euros) * 100).to_i
  end
end
