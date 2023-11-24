# frozen_string_literal: false

require "debug"

require_relative "config/routes"
require_relative "router"

# :nodoc:
class App
  def call(env)
    headers = { "Content-type" => "text/html" }
    response = router.build_response(env)
    [200, headers, [response]]
  end

  private

  def router
    Router.instance
  end
end
