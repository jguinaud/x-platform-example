require 'calabash-android/operations'
include Calabash::Android::Operations

def page(clazz)
  clazz.new(self)
end

module Calabash
  class ABase
    def initialize(world)
      @world = world
    end

    def page(clazz)
      clazz.new(@world)   
    end

    def embed(*args)
      @world.embed(*args)
    end

    def step(*args)
      @world.step(*args)
    end
  end
end