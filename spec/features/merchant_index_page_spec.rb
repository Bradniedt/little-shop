require 'rails_helper'

describe 'as a visitor' do
  context 'when I visit /merchants' do
    it 'should see all active merchants and their info' do
      user_1 = User.create(name: 'User One', street: 'Street One', city: 'City One', state: 'State1',
        zip: 'ZIP1', email: 'email1@aol.com', password: 'password1', role: 1)
      user_2 = User.create(name: 'User Two', street: 'Street Two', city: 'City Two', state: 'State2',
        zip: 'ZIP2', email: 'email2@aol.com', password: 'password2', role: 1, enabled: false, created_at: 2.days.ago)
      user_3 = User.create(name: 'User Three', street: 'Street Three', city: 'City Three', state: 'State3',
        zip: 'ZIP3', email: 'email3@aol.com', password: 'password3', role: 1)
      user_4 = User.create(name: 'User Four', street: 'Street Four', city: 'City Four', state: 'State4',
        zip: 'ZIP4', email: 'email4@aol.com', password: 'password4', created_at: 4.days.ago)
        
      visit merchants_path

      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_1.city)
      expect(page).to have_content(user_1.state)
      expect(page).to have_content(user_1.created_at)
      expect(page).to_not have_content(user_2.name)
      expect(page).to_not have_content(user_2.city)
      expect(page).to_not have_content(user_2.state)
      expect(page).to_not have_content(user_2.created_at)
      expect(page).to have_content(user_3.name)
      expect(page).to have_content(user_3.city)
      expect(page).to have_content(user_3.state)
      expect(page).to have_content(user_3.created_at)
    end
    
    it 'should show an area with statistics showing top merchants by price and quantity' do
      merchant_1 = create(:merchant)
      item_1 = create(:item, user: merchant_1)
      item_2 = create(:item, user: merchant_1)
      item_3 = create(:item, user: merchant_1)
      create(:fulfilled_order_item, item: item_1)
      create(:fulfilled_order_item, item: item_2)
      create(:fulfilled_order_item, item: item_3)
      
      merchant_2 = create(:merchant)
      item_6 = create(:item, user: merchant_2)
      create(:fulfilled_order_item, item: item_6)
      
      merchant_3 = create(:merchant)
      
      merchant_4 = create(:merchant)
      item_4 = create(:item, user: merchant_4)
      item_5 = create(:item, user: merchant_4)
      create(:fulfilled_order_item, item: item_4)
      create(:fulfilled_order_item, item: item_5)
      
      visit merchants_path
      
      # within "#statistics" do
      #   expect(page).to have_content("Top Merchants by Price: ")
      # end
      # 
      within "#statistics" do
        expect(page).to have_content("Top Merchants by Quantity: \n#{merchant_1.name}\n#{merchant_4.name}\n#{merchant_2.name}")
      end
      
    end
  end
end
