require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is nil if there is no name' do
      @category = Category.new
      @product = Product.new
      expect(@product.name).to be_nil
    end

    it 'saves a product succesfully when all 4 parameters are filled' do
      @category = Category.create(name: 'Clothes')
      @product = Product.create(name: 'hoodie', category: @category, quantity: 1, price: 100)
      @product.save!
      expect(@product).to be_valid
    end

    it 'throws an error if the name is blank' do
      @category = Category.create(name: "Decoration")
      @product = Product.create(name: nil, price: 320, quantity: 2, category_id: @category.id)
      expect(@product.name).to eql(nil)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'throws an error if the quantity is blank' do
      @category = Category.create(name: 'Clothes')
      @product = Product.create(name: 'hoodie', category: @category, quantity: nil, price: 100)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'throws an error if the quantity is blank' do
      @product = Product.create(name: 'hoodie', category: nil, quantity: 3, price: 100)
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    it 'throws an error if the price is not a number' do
      @category = Category.create(name: 'Clothes')
      @product = Product.create(name: 'hoodie', category: @category, quantity: 3, price_cents: nil)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end


  end
end