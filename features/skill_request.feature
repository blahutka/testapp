Feature: Send help request
  In order to help home owners to find best price and
  skilled contractor who can accomplish work on house according their requirements

  Scenario: Test paths
    When I go to the home page 
    Then I should be at the home page
    And the home page should match route /

  Scenario: Test new requirement
    When I go to the new_skill_requirement page
    Then I should be at the new_skill_requirement page
    And the new_skill_requirement page should match route /skill_requirements/new
    

