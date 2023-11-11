# frozen_string_literal: false

require "rack"
require_relative "app"

use Rack::Reloader, 0
# More or less App.new.call(env) underneath...
run App.new
