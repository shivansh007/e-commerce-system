require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validation' do
    context 'success' do
      it 'should have valid attributes' do
        category = build(:category)
        category.should be_valid
      end
    end

    context 'failure' do
      it 'should not have an empty name' do
        category = build(:category, name: '')
        category.should_not be_valid
      end
    end
  end

  context 'association' do
    context 'success' do
      it 'should have many items' do
        category = create(:category)
        item1 = create(:item, category_id: category.id)
        item2 = create(:item, category_id: category.id)
        category.items.includes(item1,item2).should be_truthy
      end
    end
  end
end
