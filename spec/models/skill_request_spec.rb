# -*- encoding : utf-8 -*-
require "spec_helper"

RSpec.configure do |c|
  c.use_transactional_fixtures = false
  c.before(:each) { DatabaseCleaner.clean_with(:truncation) }
end

describe SkillRequest do

  it 'saves with requirements' do
    skill_requirement = FactoryGirl.create(:skill_requirement_valid)
    skill_request = FactoryGirl.build(:home_owner_request, :skill_requirement_attributes => {:id => skill_requirement.id })
    skill_request.save!
    skill_request.skill_requirement.should eq(skill_requirement)
  end

  #it 'should have skill tags' do
  #  tags = SkillRequest.tagged_with(["zednik", "pokryvac"], :match_all => :true)
  #  tags.should have(1).record
  #end
  #
  #context 'contractor' do
  #  before(:each) {}
  #
  #  it 'should have skill tags' do
  #    contractor.should have(3).skills
  #  end
  #
  #  it 'should match home_owner request tags' do
  #    FactoryGirl.create(:contractor_profile, :skill_list => ['natěrač', 'malíř'])
  #    FactoryGirl.create(:contractor_profile, :skill_list => ['zedník', 'topenář'])
  #    FactoryGirl.create(:contractor_profile, :skill_list => ['instalatér', 'pokrývač'])
  #    FactoryGirl.create(:contractor_profile, :skill_list => ['zedník', 'pokrývač'])
  #
  #    skill_request = FactoryGirl.create(:home_owner_request, :skill_list => ['pokrývač', 'zedník']).skill_list
  #    match =  AccountProfile.tagged_with(skill_request, :any => true)
  #    #pp match.first.skill_list
  #    match.should have(3).record
  #  end
  #
  #end

  #subject { home_owner }

  #it { should have_many(:price_bids).through(:job_invitations)}

  #it 'should add job_invitation' do
  #  subject.job_invitations.build FactoryGirl.attributes_for(:job_invitation)
  #  subject.save
  #  subject.should have(1).job_invitation
  #end

  #it 'should not be able to send invitation to yourself' do
  #  pending
  #end
  #
  #it 'should have :state errors' do
  #  home_owner.send_invitations
  #  home_owner.errors.should include(:state)
  #end
  #
  #it 'should send invitation' do
  #  home_owner.approve!
  #  home_owner.send_invitations
  #  home_owner.should have(0).errors
  #end


end
