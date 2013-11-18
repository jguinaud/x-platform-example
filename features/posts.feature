Feature: Posts

   @new_article
   Scenario: New posts should be immediately visible
     Given I am logged in
     And the menu is visible

     When I'm on the New Post screen
     And I post an article
     Then the article should be visible in the Posts screen

