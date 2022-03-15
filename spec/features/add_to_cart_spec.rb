require 'rails_helper'

RSpec.feature "AddToCart", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They add product to cart and see My Cart(1)" do
    # ACT
    visit root_path
    first('.button_to').click

   # for debugging only save_and_open_screenshot
   save_screenshot

    expect(page).to have_content('My Cart (1)')
  end
end
