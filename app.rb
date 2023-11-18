# frozen_string_literal: false

require "debug"
require "erb"

require_relative "router"

# :nodoc:
class App
  attr_reader :router

  def initialize
    @router = Router.instance

    Router.draw do
      get("/") { "The homepage" }
      get("/articles") { "The articles" }
      get("/articles/1") { "The first article" }
    end
  end

  def call(env)
    headers = { "Content-type" => "text/html" }

    # main_header = "Goodbye, world."
    # paragraph = "Yet another day."
    # erb = ERB.new(html_template)
    # response = erb.result(binding)

    response = router.build_response(env["REQUEST_PATH"])

    [200, headers, [response]]
  end

  def html_template
    File.read("app/views/index.html.erb")
  end
end
