require "spec_helper"

describe SkillRequest do
  let(:home_owner) { FactoryGirl.create(:home_owner_request) }
  let(:contractor) { FactoryGirl.create(:contractor_profile) }
  let(:job_invitation) { FactoryGirl.create(:job_invitation) }



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