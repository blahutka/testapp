require "spec_helper"
RSpec.configure do |c|
  c.use_transactional_fixtures = false
  c.before(:each) { DatabaseCleaner.clean_with(:truncation) }
end

describe SkillRequirement do

  describe '#new' do

    it "should do something", :transactions => false do

    end

    context 'when not logged in' do
      
      it 'should have public_id' do
        pending 'reformat from create to new'
        skill_requirement = FactoryGirl.create(:skill_requirement_valid,
                                               :skill_request => nil)
        skill_requirement.public_id.should_not be_nil
      end
    end

    context 'when not logged in' do

      it 'should not have public_id' do
        pending 'reformat from create to new'
        skill_requirement = FactoryGirl.create(:skill_requirement_valid,
                                               :skill_request => FactoryGirl.create(:home_owner_request))
        skill_requirement.public_id.should be_nil
      end
    end


  end
end