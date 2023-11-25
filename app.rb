# frozen_string_literal: false

require "debug"
require "logger"

require_relative "config/routes"
require_relative "router"

# :nodoc:
class App
  attr_reader :logger

  def initialize
    @logger = Logger.new "#{__dir__}/log/development.log", 1
  end

  def call(env)
    logger.info "#{env['REQUEST_METHOD']} : #{env['REQUEST_PATH']}"

    headers = { "Content-type" => "text/html" }
    response = router.build_response(env)
    [200, headers, [response]]
  rescue StandardError => e
    logger.add Logger::ERROR, e

    [200, headers, ["Error: #{e.message}"]]
  end

  private

  def router
    Router.instance
  end
end
