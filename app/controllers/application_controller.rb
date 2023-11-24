# frozen_string_literal: false

require "erb"

# :nodoc:
class ApplicationController
  def initialize(env)
    @env = env
  end

  def render(view_path)
    erb_template = ERB.new File.read(view_path)
    erb_template.result binding
  end
end
