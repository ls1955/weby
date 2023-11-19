# frozen_string_literal: true

require "singleton"

# :nodoc:
class Router
  include Singleton

  class << self
    def draw(&)
      instance.instance_eval(&)
    end
  end

  def initialize
    @routes = {}
  end

  def get(path, &blk)
    @routes[path] = blk
  end

  def build_response(env)
    path = env["REQUEST_PATH"]
    handler = @routes.fetch(path) { -> { "No route for #{path}" } }
    handler.call(env)
  end
end
