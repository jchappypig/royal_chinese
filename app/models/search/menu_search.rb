module Search
  class MenuSearch
    def self.search(query, page = nil)
      Menu.search do
        fulltext query do
          boost_fields name: 2.0
        end
        paginate page: page, per_page: 10
      end
    end
  end
end