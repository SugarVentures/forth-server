class ForthController < ApplicationController
  layout 'application'

  skip_authorization_check

  def index
  end

  def about
  end

  def privacy
  end

  def term_condition
  end

  def search
    @results = SearchService.new(params[:q]).run
  end
end
