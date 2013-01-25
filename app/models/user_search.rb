class UserSearch < Search
  def initialize
    super(User)
  end

  def self.perform(query, format = nil, page = nil, per_page = 10)
    searcher = UserSearch.new
    # Instant search não necessita dos includes
    format == "json" ? includes = [] : includes = [:experiences, :tags, :friends,
                                                   { :educations  => :educationable },
                                                   :courses]
    searcher.search({ :query => query, :page => page,
                      :per_page => per_page, :include => includes })
  end
end
