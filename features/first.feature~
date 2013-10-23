#Steps definitions for:
#encoding: utf-8
Feature: User can add a new movie
Scenario: Add Men in Black
  Given I am on the RottenPotatoes homepage,
  When I follow 'Add New movie',
  Then I should be on the 'Create Movie' page.
  When I fill in title with 'Men in Black',
  And I select "PG-13" from Rating,
  And I press "Save Changes",
  Then I should be on the RottenPotatoes homepage,
  And I should see "Men in Black."
#Dave in lecture 8, V3 on EdX.	
