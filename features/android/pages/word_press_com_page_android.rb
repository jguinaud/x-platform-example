class WordPressComPage < Calabash::ABase

  def trait
    login_button_query
  end

  def await(opts={})
    super
    wait_for_elements_exist([login_button_query])
  end


  def login(user)
    query("* id:'username'",{:setText => user[:email]})
    query("* id:'password'",{:setText => user[:password]})

    performAction('scroll_down')

    touch(login_button_query)

    sleep(1)#Chance to show Dialog

    wait_for(:timeout => 60, :timeout_message => "Timed out logging in") do
      current_dialogs = query("DialogTitle",:text)

      current_dialogs.empty? or current_dialogs.include?("Error") or current_dialogs.include?("No network available")
    end

    main_page = page(MainPage)

    if element_exists(main_page.trait)
      main_page
    else
      self
    end
  end

  def invalid_login_query
    login_button_query
  end

  def login_button_query
    "android.widget.Button marked:'Log In'"
  end

  def assert_invalid_login_message
    check_element_exists(invalid_login_query)
  end


end