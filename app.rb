# frozen_string_literal: false

require "debug"
require "erb"

# :nodoc:
class App
  def call(env)
    pp env["QUERY_STRING"]

    headers = { "Content-type" => "text/html" }

    main_header = "Goodbye, world."
    paragraph = "Yet another day."

    erb = ERB.new(html_template)
    response = erb.result(binding)

    [200, headers, [response]]
  end

  def html_template
    File.read("app/views/index.html.erb")
  end
end
