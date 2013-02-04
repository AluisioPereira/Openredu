class UserSearch < Search
  def initialize
    super(User)
  end

  def self.perform(query, per_page, format = nil, page = nil)
    searcher = UserSearch.new
    # Instant search não necessita dos includes
    includes = format == "json" ? [] : [:experiences, :friends, :friendships,
                                        { :educations  => :educationable }]

    searcher.search({ :query => query, :page => page,
                      :per_page => per_page, :include => includes })
  end
end
