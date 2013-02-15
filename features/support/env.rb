if ENV['PLATFORM'] == 'ios'
  require 'calabash-cucumber/cucumber'
elsif ENV['PLATFORM'] == 'android'
  require 'calabash-android/cucumber'
end



After('@new_article') do |scenario|

  @page.delete_top_article_if_matches(POSTS[:new])

end