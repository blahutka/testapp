Feature: Send requirement for contractor
  In order to help home owners to find best price and
  skilled contractor who can accomplish work on house according their requirements

  Background: Fill requirements form and submit
    Given skill tags exists
    When I go to the new skill requirement page
    And within form new skill requirement
    And I select "skill_list" with "architekt"
    And I choose "Jsem flexibilní"
    And I select "when_flexible" with "během několika týdnů"
    And I fill in "where" with "brno"
    And I fill in "description" with "opravit okna"
    And I click on button "Odeslat"

  Scenario: After submit requirements I preview information
    Then I should see info message with "Koho hledáte: architekt"
    And I should see info message with "Kdy je potřebujete: flexible"
#    And save and open page

#    When I go to spoon: "fred"'s edit page
#    Then I should be at 1st skill_requirement's show page


#  Scenario: Home owner without account send requirement
#    Given I am on the home page
#    And I follow the new requirement page
#    When I fill requirement form
#    And I follow
#
#
#  Scenario: Test paths
#    When I go to the home page
#    Then I should be at the home page
#    And the home page should match route /
#
#  Scenario: Test new requirement
#    When I go to the new_skill_requirement page
#    Then I should be at the new_skill_requirement page
#    And the new_skill_requirement page should match route /skill_requirements/new
    

