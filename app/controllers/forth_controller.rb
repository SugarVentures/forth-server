class ForthController < ApplicationController
  layout 'application'

  skip_authorization_check

  def index
    @streams = Stream.all.upcoming
  end

  def about
  end

  def privacy
  end

  def term_condition
  end

  def search
    @results = SearchService.new(params[:q]).run
    @results = Kaminari.paginate_array(@results).page(params[:page]).per(3)
  end
end
