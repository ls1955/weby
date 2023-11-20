# frozen_string_literal: true

# :nodoc:
class ArticlesController
  def initialize(env)
    @env = env
  end

  def index
    puts "Request path is #{@env['REQUEST_PATH']}"

    "This is the articles#index"
  end
end
