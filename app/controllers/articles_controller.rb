# frozen_string_literal: true

require_relative "application_controller"

# :nodoc:
class ArticlesController < ApplicationController
  def index
    puts "Request path is #{@env['REQUEST_PATH']}"

    "This is the articles#index"
  end
end
