Feature: Home owner sends requirements to find best price and contractor
  In order to help home owners to find best price and
  skilled contractor who can accomplish work on house according
  his requirements


  @logged_out_user
  Scenario Outline: I fill requirements form
    Given skill tags exists
    When I go to the new skill requirement page
    And within form new skill requirement
    And I select "skill_list" with "<skill_list>"
    And I choose "Jsem flexibilní"
    And I select "when_flexible" with "<when_flexible>"
    And I fill in "where" with "<where>"
    And I fill in "description" with "<description>"
    When I click on button "Odeslat"
    Then skill requirement should exist with where: "<where>"
    And I should be at <page>
    And I should see notice message with "<output>"
  Examples:
    | skill_list | when_flexible        | where | description   | output       | page                         |
    | architekt  | během několika týdnů | brno  | opravit dvere | Gratulujeme  | the skill_requirement's page |
    |            | během několika týdnů | praha | novou strechu | Specify more | the skill_requirements page  |

  Scenario: After submit requirements I preview information
    When I send new skill requirement request
    Then I should be at the skill_requirement's page
    And I should see preview message with "Koho hledáte: architekt"
    And I should see preview message with "Kdy je potřebujete: flexible"

  @logged_out_user
  Scenario: I am not logged in. After I submit requirements and preview them I need to login
    Given I send new skill requirement request
    And I should be at the skill_requirement's page
    And within form new skill request
    And I click on button "Odeslat žádost"
    Then I should be at the login page
    And I log in
    Then I should be at the new skill_request page
    And within form new skill request
    And I click on button "Odeslat žádost"
    Then I should be at the dashboard page
    And I follow "Title?"
    And skill request should exist
    And I should be at the skill_request's page

  @logged_in_user
  Scenario: I am logged in. After I submit requirements and preview them, I see my dashboard
    Given I send new skill requirement request
    And I should be at the skill_requirement's page
    When within form new skill request
    And I click on button "Odeslat žádost"
    Then I should be at the dashboard page
    And I follow "Title?"
    And skill request should exist
    And I should be at the skill_request's page
#    And save and open page







#    Given an account exists
#    And a user_valid exists with account: the account
#    Given I am login


#    And save and open page


#    And I should be at last skill_requirement's show page
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
    

