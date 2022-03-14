require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid if all user information are filled' do
      @user = User.new(
        first_name: 'Ella',
        last_name: 'Muller',
        email: 'Ella@email.com',
        password: '1234',
        password_confirmation: '1234'
      )
      expect(@user).to be_valid
    end

    it 'is not valid if user to be created does not have a first name' do
      @user = User.new(
        first_name: nil,
        last_name: 'Muller',
        email: 'Ella@email.com',
        password: '1234',
        password_confirmation: '1234'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to include("can't be blank")
    end

    it 'is not valid if user to be created does not have a last name' do
      @user = User.new(
        first_name: 'Ella',
        last_name: nil,
        email: 'Ella@email.com',
        password: '1234',
        password_confirmation: '1234'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to include("can't be blank")
    end


    it 'throws an error if a user with this email already exists' do
      @user1 = User.new(
        first_name: 'Ella',
        last_name: "Muller",
        email: 'Ella@email.com',
        password: '1234',
        password_confirmation: '1234'
      )
      @user1.save!

      @user2 = User.new(
        first_name: 'Julia',
        last_name: "La Mantia",
        email: 'Ella@email.com',
        password: 'aqwz',
        password_confirmation: 'aqwz'
      )
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end

    it 'throws an error if the password is too short' do
      @user = User.new(
        first_name: 'Ella',
        last_name: "Muller",
        email: 'Ella@mail.com',
        password: '123',
        password_confirmation: '123'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 4 characters)")
    end

    it 'checks if password and password_confirmation are the same' do
      @user = User.new(
        first_name: 'Ella',
        last_name: 'Muller',
        email: 'Ella@email.com',
        password: '1234',
        password_confirmation: '123A'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to include("doesn't match")
    end

    it 'is not valid when creating an account without password or password confirmation' do
      @user = User.new(
        first_name: 'Ella',
        last_name: 'Muller',
        email: 'Ella@email.com',
        password: nil,
        password_confirmation: nil
      )
      expect(@user).to_not be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    it 'is valid if the user logging in matches an existant user' do
      user2 = User.create(
        first_name: 'Ella',
        last_name: "Muller",
        email: 'ella@mail.com',
        password: '1234',
        password_confirmation: '1234'
      )
      
      expect(User.authenticate_with_credentials('ella@mail.com', '1234')).to eq(user2)
    end

    it 'logs in the user even if the email is not lowercase' do
      user3 = User.create(
        first_name: 'Ella',
        last_name: "Muller",
        email: 'ella@email.com',
        password: '1234',
        password_confirmation: '1234'
      )
      expect(User.authenticate_with_credentials('ELLA@EMAIL.com', '1234')).to have_attributes(:email => "ella@email.com")
    end
  end

end
