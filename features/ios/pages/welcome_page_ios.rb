require 'calabash-cucumber/ibase'

class WelcomePage < Calabash::IBase

  def trait
    "button marked:'Add WordPress.com Blog'"
  end


  def wordpress_blog

    touch(trait)


    page(WordPressComPage)
  end

  def await(opts={})
    super
    wait_for_animation
    self
  end

end