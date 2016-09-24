module WebImageSearch

  class Search

    attr_accessor :query

    def search_image(query, image_type, image_size = "medium")

      base_url = "https://images.search.yahoo.com/search/images"
      query = "p=#{q}"
      image_type = "&imgty=clipart"
      some_set = "&fr=sfp"
      image_size = "&imgsz=medium"


      query_url = "#{base_url}?#{query}#{image_type}#{some_set}#{image_size}"

    end

  end


end