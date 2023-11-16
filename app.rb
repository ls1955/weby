# frozen_string_literal: false

require "debug"

# :nodoc:
class App
  def call(_)
    headers = { "Content-type" => "text/html" }

    response = File.read("app/views/index.html")
    [200, headers, [response]]
  end
end
