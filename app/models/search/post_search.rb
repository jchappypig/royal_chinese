module Search
  class PostSearch
    def self.execute(query, page = nil)
      Post.search do
        fulltext query do
          boost_fields title: 2.0
        end
        paginate page: page, per_page: 10
      end
    end
  end
end