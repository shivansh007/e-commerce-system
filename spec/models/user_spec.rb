require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        user = build(:user)
        user.should be_valid
      end
    end

    context 'failure' do
      it 'should not have an empty name' do
        user = build(:user, name: '')
        user.should_not be_valid
      end
      it 'should not have an empty address' do
        user = build(:user, address: '')
        user.should_not be_valid
      end
      it 'should not have an empty phone' do
        user = build(:user, phone: '')
        user.should_not be_valid
      end
      it 'should not have an empty email' do
        user = build(:user, email: '')
        user.should_not be_valid
      end
      it 'should not have invalid email' do
        user = build(:user, email: 'shivansh')
        user.should_not be_valid
      end
      it 'should not have an empty password' do
        user = build(:user, password: '')
        user.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should have many order' do
        user = create(:user)
        order1 = create(:order, user_id: user.id)
        order2 = create(:order, user_id: user.id)
        user.orders.includes(order1, order2).should be_truthy
      end
    end
  end
end
