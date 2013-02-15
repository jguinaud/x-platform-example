require 'calabash-cucumber/ibase'

class PostsPage < Calabash::IBase

  def trait
    "navigationItemView marked:'Posts'"
  end

  def await(opts={})
    super
    wait_for_animation
    self
  end

  def assert_is_current_page
    check_element_exists(trait)
  end


end