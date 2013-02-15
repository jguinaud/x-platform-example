class WordPressComPage < Calabash::ABase

  def trait

  end

  def await(opts={})
    
  end


  def login(user)
    step %Q{I enter "#{user[:email]}" into input field number 1}
    step %Q{I enter "#{user[:password]}" into input field number 2}
    step %Q{I press "Log In"}

    sleep(1)#Chance to show Dialog

    wait_for(:timeout => 60, :timeout_message => "Timed out logging in") do
      current_dialogs = query("DialogTitle",:text)

      current_dialogs.empty? or current_dialogs.include?("Error")
    end

    main_page = page(MainPage)

    if element_exists(main_page.trait)
      main_page
    else
      self
    end
  end

  def invalid_login_query
    "* marked:'Log In'"
  end

  def assert_invalid_login_message
    check_element_exists(invalid_login_query)
  end


end