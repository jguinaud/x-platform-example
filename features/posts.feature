Feature: Posts

  Background:
    Given I am logged in
    And the menu is visible

  Scenario: Blog available
    Then I should see the "calabashtraining" blog
    And I can see the blog posts in the Posts screen

  @new_article
  Scenario: New posts should be immediately visible
    Given I'm on the New Post screen
    And I post an article
    Then the article should be visible in the Posts screen




