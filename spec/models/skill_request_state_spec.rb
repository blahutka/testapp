# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SkillRequest do

  let(:skill_request) { FactoryGirl.create(:home_owner_request) }

  context '#new request' do
    subject { skill_request }
    it { should be_created }
    it { should_not be_approved }
    it { should_not be_opened }

    context 'not approved' do
      it 'should not send invitations' do
        #subject.approve!
        lambda {skill_request.match!}.should raise_error
      end
    end
  end

  context '#approved' do
    subject { skill_request }
    before(:each) { subject.approve }

    it 'should send invitation to resque' do
      subject.open!
    end

    it { should be_approved }
    it 'should be able to cancel' do
      subject.cancel!
      should be_canceled
    end

    context '#opened' do
      before(:each) { subject.open! }
      it { should be_opened }
      it 'should be able to cancel' do
        subject.cancel!
        should be_canceled
      end

      context '#scheduled' do
        before(:each) { subject.schedule }
        it { should be_scheduled }
        it 'should be able cancel' do
          subject.cancel!
          should be_canceled
        end
      end

    end


  end
end
