class StaticController < ApplicationController
  before_filter :authenticate_user!

  def app
    render file: '/public/moblib/app', layout: false
  end
end
