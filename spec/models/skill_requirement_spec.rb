require "spec_helper"
RSpec.configure do |c|
  c.use_transactional_fixtures = false
  c.before(:each) { DatabaseCleaner.clean_with(:truncation) }
end

describe SkillRequirement do

  it "should do something", :transactions => false do
    tags = FactoryGirl.create(:skill_tags)
    #pp SkillTag.synonym_counts.order('count desc').limit(15).collect{ |v| [v.taggings.first.taggable.name, v.taggings.first.taggable.id]}.uniq
    #pp SkillTag.select_menu
    Tagging.select('tag_id, count()').group('tag_id')
    #pp SkillTag.top_tags(15).collect{|v| v.taggings.first.taggable.name}.uniq.sort{|a,b| a[0]<=>b[0]}
  end
end