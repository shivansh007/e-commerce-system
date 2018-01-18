require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        order = build(:order)
        order.should be_valid
      end
    end

    context 'failure' do
      it 'should not have an empty item' do
        order = build(:order, item_id: '')
        order.should_not be_valid
      end
      it 'should not have invalid item id' do
        order = build(:order, item_id: 'a')
        order.should_not be_valid
      end
      it 'should not have an empty user' do
        order = build(:order, user_id: '')
        order.should_not be_valid
      end
      it 'should not have invalid user id' do
        order = build(:order, user_id: 'a')
        order.should_not be_valid
      end
      it 'should not have an empty payment_mode' do
        order = build(:order, payment_mode: '')
        order.should_not be_valid
      end
      it 'should not have an empty payment_status' do
        order = build(:order, payment_status: '')
        order.should_not be_valid
      end
      it 'should not have an empty order_status' do
        order = build(:order, order_status: '')
        order.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should have one invoice' do
        order = create(:order)
        invoice = create(:invoice, order_id: order.id)
        invoice.order.should eq order
      end
      # it 'should not have many invoice' do
      #   order = create(:order)
      #   invoice1 = create(:invoice, order_id: order.id)
      #   invoice2 = create(:invoice, order_id: order.id)
      #   invoice1.order.should_not eq invoice2.order
      # end
      it 'should belong to user' do
        user = create(:user)
        order = create(:order, user_id: user.id)
        order.user.should eq user
      end
      it 'should belong to item' do
        item = create(:item)
        order = create(:order, item_id: item.id)
        order.item.should eq item
      end
    end
  end
end
