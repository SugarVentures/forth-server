class ForthController < ApplicationController
  layout 'application'

  skip_authorization_check

  def index
    @streams = Stream.all.upcoming
    @upcoming_stream = @streams.order('view_count DESC').first
    @recommended_stream = Stream.all.order('view_count DESC').first
    @featured_stream = Stream.all.order('view_count DESC').first
    @popular_stream = Stream.all.order('view_count DESC').first
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
