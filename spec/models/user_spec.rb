# -*- encoding : utf-8 -*-
require 'spec_helper'

describe User do

  it 'should have account' do
    user = FactoryGirl.create(:user_valid)
    user.account.should be_a(Account)
  end

  it 'account has user email' do
    user = FactoryGirl.create(:user_valid)
    user.account.email.should eq(user.email)
  end

  it 'should add account' do
    lambda { FactoryGirl.create(:user_valid) }.should
  end

  
end
