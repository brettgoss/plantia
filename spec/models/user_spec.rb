require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is true with valid attributes" do

      @user = User.new({
                name:"test",
                email: "test@test.com",
                password: "test",
                password_confirmation: "test"
                })
        expect(@user.save).to be true
      end

    it "is false with no name" do

      @user = User.new({
                name:"",
                email: "test@test.com",
                password: "test",
                password_confirmation: "test"
                })
      expect(@user.save).to be false
    end

    it "is false with no password" do
      @user = User.new({
                name:"test",
                email: "test@test.com",
                password: "",
                password_confirmation: "test"
                })
      expect(@user.save).to be false
    end


    it "is false with no password_confirmation" do
      @user = User.new({
                name:"test",
                email: "test@test.com",
                password: "test",
                password_confirmation: ""
                })
      expect(@user.save).to be false
    end

    it "should not save if password & confirmation diff" do
      @user = User.new({
                name:"test",
                email: "test@test.com",
                password: "test",
                password_confirmation: "NOTTEST"
                })
      expect(@user.save).to be false
    end

    it "should not save if password is too short" do
      @user = User.new({
                name:"test",
                email: "test@test.com",
                password: "te",
                password_confirmation: "te"
                })
      expect(@user.save).to be false
    end

    it "should not allow duplicate user emails" do
      @user1 = User.new({
                name:"test",
                email: "test@test.com",
                password: "test",
                password_confirmation: "test"
                })
      @user2 = User.new({
                name:"test",
                email: "test@test.com",
                password: "test",
                password_confirmation: "test"
                })
      @user1.save
      expect(@user2.save).to be false
    end

    it "should not allow same emails with diff case" do
      @user1 = User.new({
                name:"test",
                email: "test@test.com",
                password: "test",
                password_confirmation: "test"
                })
      @user2 = User.new({
                name:"test",
                email: "TEST@test.com",
                password: "test",
                password_confirmation: "test"
                })
      @user1.save
      expect(@user2.save).to be false
    end

  end

  describe '.authenticate_with_credentials' do

   it 'should return user if params are correct' do
      user = User.new({
              name: 'test',
              email: "test@test.com",
              password: 'test',
              password_confirmation: "test"
              })
      user.save
      @user = User.authenticate_with_credentials("test@test.com", "test")
      expect(@user).to eql user
   end

   it 'should return user if email has extra spaces' do
      user = User.new({
              name: 'test',
              email: "test@test.com",
              password: 'test',
              password_confirmation: "test"
              })
      user.save
      @user = User.authenticate_with_credentials(" test@test.com ", "test")
      expect(@user).to eql user
   end

   it 'should return user if email has diff case' do
      user = User.new({
              name: 'test',
              email: "test@test.com",
              password: 'test',
              password_confirmation: "test"
              })
      user.save
      @user = User.authenticate_with_credentials("TEST@test.com", "test")
      expect(@user).to eql user
   end

   it 'should return nil if email is wrong' do
      user = User.new({
              name: 'test',
              email: "test@test.com",
              password: 'test',
              password_confirmation: "test"
              })
      user.save
      @user = User.authenticate_with_credentials("nottest@test.com", "test")
      expect(@user).to be nil
   end

  end
end