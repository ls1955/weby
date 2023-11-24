# frozen_string_literal: true

require "singleton"

require_relative "app/controllers/articles_controller"

# :nodoc:
class Router
  include Singleton

  # A wrapper to instance_eval the block
  class << self
    def draw(&)
      instance.instance_eval(&)
    end
  end

  def initialize
    @routes = {}
  end

  # Appends the blk into the routes if blk is given
  # If the path is in form of "controller#action", append controller's action into the routes
  def get(path, &blk)
    return @routes[path] = blk if blk

    return unless path.include? "#"

    ctrller, action = path.split "#"
    ctrller_klass = Object.const_get("#{ctrller.capitalize}Controller")
    # For now turn "controller#action" to "/controller/action" path
    new_path = "/#{path.tr('#', '/')}"

    @routes[new_path] = ->(env) { ctrller_klass.new(env).send(action) }
  end

  # Calls the handler for the route
  def build_response(env)
    path = env["REQUEST_PATH"]
    handler = @routes.fetch(path) { proc { "No route for #{path}" } }
    handler.call(env)
  end
end
