class WelcomePage < Calabash::ABase

  def trait

  end

  def wordpress_blog
    touch("android.widget.Button marked:'Add blog hosted at WordPress.com'")
    page(WordPressComPage)
  end

  def await(opts={})

    begin
      r = performAction('assert_text', "GNU GENERAL PUBLIC LICENSE", false)
    rescue
      touch("android.widget.Button marked:'Accept'")
    end
    wait_for_elements_exist(["* {text BEGINSWITH 'Start blogging'}"])

    self
  end

end