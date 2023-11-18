# frozen_string_literal: true

# :nodoc:
class Router
  def initialize
    @routes = {}
  end

  def draw(&)
    instance_eval(&)
  end

  def get(path, &blk)
    @routes[path] = blk
  end

  def build_response(path)
    handler = @routes.fetch(path) { -> { "No route for #{path}" } }
    handler.call
  end
end
