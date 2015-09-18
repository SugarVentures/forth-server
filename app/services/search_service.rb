class SearchService
  def initialize(keyword)
    @keyword = keyword
    @results = []
  end

  def run
    channels = Channel.search(@keyword).to_a
    streams = Stream.search(@keyword).to_a
    users = User.search(@keyword).to_a

    1000.times do
      break if channels.nil? && streams.nil? && users.nil?
      shift_result(channels, streams, users)
    end
    @results
  end

  private

  def shift_result(c, s, u)
    @results << c.shift if c.present?
    @results << s.shift if s.present?
    @results << u.shift if u.present?
  end
end
