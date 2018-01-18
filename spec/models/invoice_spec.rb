require 'rails_helper'

RSpec.describe Invoice, type: :model do
  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        invoice = build(:invoice)
        invoice.should be_valid
      end
    end

    context 'failure' do
      it 'should not have an empty order id' do
        invoice = build(:invoice, order_id: '')
        invoice.should_not be_valid
      end
      it 'should have a valid order id' do
        invoice = build(:invoice, order_id: 'a')
        invoice.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should belong to order' do
        order = create(:order)
        invoice = create(:invoice, order_id: order.id)
        invoice.order.should eq order
      end
    end
  end
end
