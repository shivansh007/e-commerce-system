require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        item = build(:item)
        item.should be_valid
      end
    end

    context 'failure' do
      it 'should not have an empty name' do
        item = build(:item, name: '')
        item.should_not be_valid
      end
      it 'should not have an empty description' do
        item = build(:item, description: '')
        item.should_not be_valid
      end
      it 'should not have an empty brand' do
        item = build(:item, brand: '')
        item.should_not be_valid
      end
      it 'should not have an empty price' do
        item = build(:item, price: '')
        item.should_not be_valid
      end
      it 'should not have invalid price' do
        item = build(:item, price: 'a')
        item.should_not be_valid
      end
      it 'should not have an empty category id' do
        item = build(:item, category_id: '')
        item.should_not be_valid
      end
      it 'should not have invalid category id' do
        item = build(:item, category_id: 'a')
        item.should_not be_valid
      end
      it 'should not have an empty stock' do
        item = build(:item, stock: '')
        item.should_not be_valid
      end
      it 'should not have invalid stock' do
        item = build(:item, stock: 'a')
        item.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should belong to category' do
        category = create(:category)
        item = create(:item, category_id: category.id)
        item.category.should eq category
      end
      it 'should have many orders' do
        item = create(:item)
        order1 = create(:order, item_id: item.id)
        order2 = create(:order, item_id: item.id)
        item.orders.includes(order1, order2).should be_truthy
      end
    end
  end
end
