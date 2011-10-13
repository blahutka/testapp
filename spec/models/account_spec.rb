# -*- encoding : utf-8 -*-
require 'spec_helper'


describe Account do
  let(:account) { FactoryGirl.create(:account) }
  let(:user)    { FactoryGirl.create(:user) }


  context '#users' do
    it { should have_many :users }
    it 'should add user' do
      account.should have(0).users #<< user
    end
  end

  context "#profiles" do
    it { should have_many(:profiles) }
    it { should have_many :job_invitations }

    it 'should add profile' do
      account.profiles << FactoryGirl.create(:contractor_profile)
      account.should have(1).profile
    end
  end

  context "#skill_requests" do
    it { should have_many :skill_requests }

    it 'should add skill_request' do
      account.skill_requests << FactoryGirl.create(:home_owner_request)
      account.should have(1).skill_request
    end
  end

end
