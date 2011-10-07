require 'spec_helper'

describe SkillRequest do

  let(:skill_request) { FactoryGirl.create(:skill_request) }

  context '#new request' do
    subject { skill_request }
    it { should be_created }
    it { should_not be_approved }
    it { should_not be_invitation_opened }

    context 'not approved' do
      it 'should not send invitations' do
        #subject.approve!
        puts subject.errors
        skill_request.send_invitations

        skill_request.should have(1).error
      end
    end
  end

  context '#approved' do
    subject { skill_request }
    before(:each) { subject.approve }

    it { should be_approved }
    it 'should be able to terminate' do
      subject.terminate!
      should be_terminated
    end

    context '#invitation_opened' do
      before(:each) { subject.open_invitations! }
      it { should be_invitation_opened }
      it 'should be able to terminate' do
        subject.terminate
        should be_terminated
      end

      context '#scheduled' do
        before(:each) { subject.schedule }
        it { should be_scheduled }
        it 'should be able terminate' do
          subject.terminate
          should be_terminated
        end
      end

    end


  end
end
