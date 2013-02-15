require 'calabash-cucumber/ibase'

class ViewSitePage < Calabash::IBase

  def initialize(world, site)
    super(world)
    @site = site
  end

  def query_for_navbar(text)
    "navigationItemView {accessibilityLabel LIKE '#{text}*'}"
  end

  def query_for_title(post_title)
    "webView css:'h1 a' {textContent LIKE '*#{post_title}*'}"
  end

  def assert_post_present(post)
    check_element_exists(query_for_title(post[:title]))
    check_element_exists("webView css:'p' {textContent BEGINSWITH '#{post[:content]}'}")
  end


  def details_for_post(post_title)
    touch(query_for_title(post_title))
    wait_for_elements_exist([query_for_navbar(post_title)], :timeout => 30)
  end

  def ensure_like_button_exists
    scroll("webView", :down) #there is a like button at top, we don't want this
    wait_poll(:until_exists => "webView css:'a' textContent:'Like'") do
      scroll("webView", :down)
    end
    scroll("webView", :down)
  end

  def trait
    query_for_navbar(@site)
  end

  def await(opts={})
    super
    wait_for_elements_do_not_exist(["view marked:'Loading...'"], :timeout => 60)
    self
  end

end