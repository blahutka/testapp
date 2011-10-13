require "spec_helper"

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.after(:each) do

  end
end

describe JobInvitation do

  #let(:job_invitation) { FactoryGirl.create(:home_owner_with_contractor_invitation) }
  let(:home_owner_request) { FactoryGirl.create(:home_owner_request) }
  let(:contractor_profile) { FactoryGirl.create(:contractor_profile) }
  #specify { home_owner_request.should exist }

  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
    contractor_profile
    home_owner_request
  end


  it 'should be open' do
    home_owner_request.approve!
    home_owner_request.should be_opened
  end

  it 'should send send invitations' do
    home_owner_request.approve!
    contractor_profile.should have(1).invitation
  end

  it 'should invite more' do
    home_owner_request.approve!
    home_owner_request.match!
    contractor_profile.should have(2).invitations
  end

  it 'should reopen invitation' do
    home_owner_request.approve!
    3.times { home_owner_request.match! }
    home_owner_request.should be_matched
    contractor_profile.should have(4).invitations
  end

  context 'Contractor' do
    before(:each) do
      home_owner_request.approve!
    end

    it 'should have no bids' do
      price_bid = FactoryGirl.create(:price_bid)
      contractor_profile.account.should have(1).job_invitation
      contractor_profile.account.job_invitations.first.price_bids << price_bid

      home_owner_request.account.should have(1).skill_request
      home_owner_request.should have(1).price_bid
      home_owner_request.price_bids.first == price_bid
    end
  end


  after(:each) do

  end

  #before(:each) do
  #  contractor_profile
  #  home_owner_request.approve!
  #  home_owner_request.send_invitations
  #end
  #
  #specify "should setup factories" do
  #  contractor_profile.should belong_to :account
  #  home_owner_request.should belong_to :account
  #  home_owner_request.account.email.should include('home')
  #  Account.should have(2).records
  #end
  #
  #context 'home owner send invitation' do
  #
  #  it 'should contractor receive one' do
  #    contractor_profile.should have(1).invitation
  #  end
  #end
end