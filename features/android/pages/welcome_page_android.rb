class WelcomePage < Calabash::ABase

  def trait

  end

  def wordpress_blog
    performAction "press", "Add blog hosted at WordPress.com"
    page(WordPressComPage)
  end

  def await(opts={})

    begin
      r = performAction('assert_text', "GNU GENERAL PUBLIC LICENSE", false)
    rescue
      performAction "press", "Accept"
    end
    performAction "wait_for_text", "Start blogging"
    self
  end

end