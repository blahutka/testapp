require 'spec_helper'

def create_account

end

describe Account do
  let(:account) { FactoryGirl.create(:account) }

  context "#profiles" do
    
    it { should have_many(:profiles) }

    it 'should add profile' do
      account.profiles << FactoryGirl.create(:profile)
      account.should have(1).profile
    end


  end

  context "#projects" do

    it { should have_many :projects }

    it 'should add project' do
      account.projects << FactoryGirl.create(:project)
      account.should have(1).project
    end
  end
end
