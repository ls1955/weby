# frozen_string_literal: false

# :nodoc:
class App
  def call(_)
    headers = { "Content-type" => "text/html" }
    response = File.read("#{__dir__}/app/views/index.html")

    [200, headers, [response]]
  end
end
