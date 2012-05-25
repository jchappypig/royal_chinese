module Search
  class FollowerSearch
    def self.execute(query, page = nil)
      Follower.search do
        fulltext query do
          boost_fields email: 2.0
        end
        paginate page: page, per_page: 10
      end
    end
  end
end