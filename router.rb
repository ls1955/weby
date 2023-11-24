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

  # Appends the blk into the routes and return if blk is given
  # If path in form "controller#action", append the block that return rendered view
  def get(path, &blk)
    return @routes[path] = blk if blk

    return unless path.include? "#"

    ctrller_name, action = path.split "#"
    ctrller_klass = Object.const_get("#{ctrller_name.capitalize}Controller")
    # For now turn "controller#action" to "/controller/action" path
    new_path = "/#{path.tr('#', '/')}"

    @routes[new_path] = proc do |env|
      ctrller = ctrller_klass.new env
      ctrller.send action
      ctrller.render "app/views/#{ctrller_name}/#{action}.html.erb"
    end
  end

  # Calls the handler for the route
  def build_response(env)
    path = env["REQUEST_PATH"]
    handler = @routes.fetch(path) { proc { "No route for #{path}" } }
    handler.call(env)
  end
end
