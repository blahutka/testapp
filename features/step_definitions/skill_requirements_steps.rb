# -*- encoding : utf-8 -*-

Given /^I send new skill requirement request$/ do
  steps %Q{
    Given skill tags exists
    When I go to the new skill requirement page
    And within form new skill requirement
    And I select "skill_list" with "architekt"
    And I choose "Jsem flexibilní"
    And I select "when_flexible" with "během několika týdnů"
    And I fill in "where" with "brno"
    And I fill in "description" with "opravit okna"
    When I click on button "Odeslat"
    Then skill requirement should exist with where: "brno"
        }
end