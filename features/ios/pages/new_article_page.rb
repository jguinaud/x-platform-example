require 'calabash-cucumber/ibase'

class NewArticlePage < Calabash::IBase

  def await
    wait_for_animation
    check_element_exists("navigationItemView marked:'New Post'")
  end

  def publish_article(article)
    touch("view marked:'Title:'", :offset => {:x => 200})
    wait_for_animation

    keyboard_enter_text(article[:title])
    done
    wait_for_animation

    touch("label text:'Tap here to begin writing'")


    keyboard_enter_text(article[:body])
    touch("button marked:'Done'")
    wait_for_animation

    touch("button marked:'Publish'")

    page(MainPage)

  end


end