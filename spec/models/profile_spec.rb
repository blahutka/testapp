require 'spec_helper'

describe AccountProfile do
  let(:profile) { FactoryGirl.create(:profile) }
  
  it { should have_many :invitations }
  it { should belong_to :account }

  it 'should have Factory' do
    profile
  end

  context 'new profile' do
    it 'it should have no invitations' do
      profile.should have(0).invitations
    end

    context 'receive invitation' do
      let!(:invitations) { profile.invitations << FactoryGirl.create(:project_invitation) }
      
      it 'should receive invitation' do
          profile.should have(1).invitations
      end

    end
  end

end

