require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  FactoryBot.define do
    factory :user do
       trait :invalid_user do
        first_name { 'Niyanta' }
        last_name { 'Prasad' }
        user_name { 'niyantaprasad' }
        email_id { 'niyanta16@gmail.com' }
        phone_no { '9957086386' }
        password { 'pineapple' }
        password_confirmation { 'pineapple' }
      end
  end

  describe "POST /create" do
    it "signup a user" do
      headers = { "ACCEPT" => "application/json" } 
      @invalid_user  = FactoryBot.create :user, :invalid_user
      expect do
        post "/users", :params => { :first_name => @invalid_user.first_name, :last_name => @invalid_user.last_name, :user_name => @invalid_user.user_name, :email_id => @invalid_user.email_id, :phone_no =>  @invalid_user.phone_no, :password => @invalid_user.password, :password_confirmation => @invalid_user.password_confirmation}, :headers => headers
      end.to change(User, :count).by(0)
    end
  end
end
