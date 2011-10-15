# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Skill request form" do
  #before(:all) { Capybara.current_driver = :selenium }
  before(:all) { visit new_skill_request_path }

  context '#new' do
    it 'should show form' do
      page.should have_css('form#new_skill_request')
    end

    context 'skill field' do
      it 'should have skill field' do
        within('form#new_skill_request') do
          page.should have_css('input')
        end
        page.save_and_open_page
      end
      it 'should show help' do
        within('form#new_skill_request') do
          fill_in('skill_request_skill_list', :with => 'zednik')
          find('#skill_request_skill_list').click
        end
      end

    end

  end

end
