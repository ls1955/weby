# frozen_string_literal: true

require_relative "application_controller"

# :nodoc:
class ArticlesController < ApplicationController
  def index
    @title = "Some great title here."
    @paragraph = "Today is another day, just like any other day."
  end
end
