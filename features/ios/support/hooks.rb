class CallbackWorld
  include Calabash::Cucumber::Operations

  def on_launch
    begin
      wait_for_elements_exist(["alertView label text:'Update Available'"], :timeout => 5)
      wait_for_animation
      touch("view marked:'Dismiss'")
    rescue
      #May not appear so ignore timeout error
    end
  end
end

World do
  CallbackWorld.new
end