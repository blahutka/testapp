# -*- encoding : utf-8 -*-
require 'spec_helper'

RSpec.configure do |c|
  c.use_transactional_fixtures = false
  c.before(:each) { DatabaseCleaner.clean_with(:truncation) }
end

describe SkillRequirementsController do

  context '#create' do
    subject { FactoryGirl.build(:skill_requirement_valid) }
    it { should be_valid }

    it 'succeeds' do
      post :create, attributes_for(:skill_requirement)
      response.should be_success
    end

    it "create an skill requirement" do
      skill = FactoryGirl.create(:skill_requirement_valid)
      lambda { post :create, attributes_for(:skill_requirement_valid) }.
          should change {
        SkillRequirement.count
      }.by(1)
    end

    #context 'not found skill' do
    #  subject { FactoryGirl.create(:skill_requirement_valid, :skill_list => 'boom') }
    #  it 'should be valid' do
    #    skill_requirement.should be_valid
    #  end
    #end

  end

  context 'not valid' do
    subject { FactoryGirl.build(:skill_requirement_valid, :skill_list => '') }
    it { should_not be_valid }
  end
end
