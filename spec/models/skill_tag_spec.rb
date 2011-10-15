# -*- encoding : utf-8 -*-
require 'spec_helper'

RSpec.configure do |c|
  c.use_transactional_fixtures = false
  c.before(:each) { DatabaseCleaner.clean_with(:truncation) }
end

describe SkillTag do

  it 'should create ownership tag' do
    skill_tag = FactoryGirl.create(:skill_tag)
    FactoryGirl.create(:contractor_profile)
    request = FactoryGirl.create(:home_owner_request)

    skill_tag.tag(request, :with => ['zedník', 'podavač', 'zednik', 'podavac'], :on => :skills)
  end

  it 'should have space' do
    request = FactoryGirl.create(:home_owner_request, :skill_list => 'nahazujici zednik, prodava')
  end

  it 'should create default synonym' do
    skill_tag = FactoryGirl.create(:skill_tag, :name => 'zedník')
    skill_tag.synonym_list.should include('zedník')
  end

  it 'should remove special chars' do
    skill_tag = FactoryGirl.create(:skill_tag, :name => 'ěščřžýáíéůú čšřš',
                                   :synonym_list => 'josef, človek ,  člověk malý  , neco')
    skill_tag.synonym_list.should include('josef', 'človek', 'clovek', 'clovek maly', 'neco')
  end

end
