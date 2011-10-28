# -*- encoding : utf-8 -*-
require 'spec_helper'

RSpec.configure do |c|
  c.use_transactional_fixtures = false
  c.before(:each) { DatabaseCleaner.clean_with(:truncation) }
end

describe SkillRequirementsController do

  describe '#new' do
    context 'when not logged in' do

      context 'public id exists in cookie' do
        it 'redirect to edit'
      end

      context 'public id not exist in cookie' do
        it 'has empty form'
      end
    end

    context 'when logged in' do

      context 'public id exist in cookie' do
        it 'redirect to edit'
      end

    end

  end

  describe '#create' do

    context 'when logged in' do
      it 'clear cookie public id'
      it 'assign to current user'
      it 'saves to db'

      context 'when skill tag not found' do
        it 'redirect to specify skills page'
      end

      context 'when skill tag is found' do
        it 'redirect to dashboard page'
      end

    end

    context 'when not logged in' do
      it 'saves public id to cookie'
      it 'saves to db'

      context 'when skill_tag not found' do
        it 'redirect specify skill page'
      end

      context 'when skill tag is found' do
        it 'redirect to login page'
      end

    end


  end

  describe '#edit' do
    it 'find by public id or current user'
    it 'not found redirect to new form'

    context 'when logged in' do

      context 'public id exist' do
        it 'load data from db'
        it 'assign to current user request'
      end

    end

    context 'when not logged in' do

      context 'public id not exist' do
        it 'redirect to new'
      end

      context 'public id exist' do
        it 'find by public id'
        it 'load data from db'
        it 'assign to current user request'
      end

    end
  end

  describe '#update' do

  end

  describe '#specify' do
    it 'find tag categories'
    it 'find similar tags'
    it 'renders specify skill page'

  end


  #context 'not valid' do
  #  before { post 'create', :skill_requirement => {} }
  #
  #  it { response.should render_template('skill_requirements/new') }
  #  it { assigns(:skill_requirement).should_not be_nil }
  #  it { assigns(:skill_requirement).errors_on(:where).should_not be_nil }
  #end
  #
  #context 'valid' do
  #  #before { post 'create', :skill_requirement => attributes_for(:skill_requirement_valid) }
  #
  #  it "redirect show" do
  #    FactoryGirl.create(:skill_tag)
  #    post 'create', :skill_requirement => attributes_for(:skill_requirement_valid)
  #    response.should redirect_to(skill_requirement_path(assigns(:skill_requirement)))
  #  end
  #
  #  context 'without found skill_tag' do
  #    before { post 'create', :skill_requirement => attributes_for(:skill_requirement_valid, :skill_list => 'bamboo') }
  #
  #    it { assigns(:skill_requirement).errors.should have(0).items }
  #    it 'pass params' do
  #      assigns(:skill_requirement).skill_list.should include('bamboo')
  #    end
  #
  #    it { flash[:notice].should include('Specify') }
  #
  #    it 'should render specify skills' do
  #      response.should render_template('skill_requirements/specify')
  #    end
  #  end
  #end


end
