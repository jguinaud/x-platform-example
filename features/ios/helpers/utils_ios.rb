def logged_in?
  element_exists("button marked:'Toggle'")
end

def wait_for_animation
  sleep(0.5)
end