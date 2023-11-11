# frozen_string_literal: false

# :nodoc:
class App
  def call(env)
    headers = { "Content/type" => "text/html" }
    response = ["<h1>Goodbye, world.</h1>"]
    
    [200, headers, response]
  end
end
