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
    return @routes[path] = blk if blk

    return unless path.include? "/"

    ctrller, action = path.split "/"
    ctrller_klass = Object.const_get("#{ctrller.capitalize}Controller")

    @router[path.prepend("/")] = proc do |env|
      ctrller_klass.new(env).send(action)
    end
  end

  def build_response(env)
    path = env["REQUEST_PATH"]
    handler = @routes.fetch(path) { -> { "No route for #{path}" } }
    handler.call(env)
  end
end
