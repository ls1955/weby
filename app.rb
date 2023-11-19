# frozen_string_literal: false

require "debug"
require "erb"

require_relative "config/routes"
require_relative "router"

# :nodoc:
class App
  def call(env)
    headers = { "Content-type" => "text/html" }

    # main_header = "Goodbye, world."
    # paragraph = "Yet another day."
    # erb = ERB.new(html_template)
    # response = erb.result(binding)

    response = router.build_response(env)

    [200, headers, [response]]
  end

  def html_template
    File.read("app/views/index.html.erb")
  end

  private

  def router
    Router.instance
  end
end
