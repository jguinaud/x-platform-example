require 'calabash-android/operations'

def page(clazz)
  clazz.new(self)
end

module Calabash
  class ABase
    include Calabash::Android::Operations

    def initialize(world)
      @world = world
    end

    def page(clazz)
      clazz.new(@world)
    end

    def current_page?
      element_exists(trait)
    end

    def embed(*args)
      @world.embed(*args)
    end

    def step(*args)
      @world.step(*args)
    end
  end
end
