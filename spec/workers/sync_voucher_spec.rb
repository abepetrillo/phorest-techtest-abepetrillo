require 'rails_helper'

describe SyncVoucher do
  describe '#perform' do

    context 'given a voucher' do
      context 'that does not exist' do
        it 'fails gracefully'do
          result = described_class.new.perform(99999)
          expect(result).to eql true
        end
      end

      context 'that exists' do
        context 'and is not synced' do
           it 'syncs and collects a voucher id' do
            voucher = Voucher.create!(
              client_id: 'fake_client_id',
              creating_branch_id: 'fake_branch_id',
              original_balance: 1000
            )
            result = subject.perform(voucher.id)
            expect(result).to eql true
            voucher.reload
            expect(voucher.voucher_id).to be_present
            expect(voucher.synced_at).to be_present
          end
        end
      end
    end
  end
end
