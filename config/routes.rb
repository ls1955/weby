# frozen_string_literal: true

require_relative "../router"

Router.draw do
  get("/") { "The homepage" }
  get "articles#index"
  get("/articles/1") { "The first article" }
end
