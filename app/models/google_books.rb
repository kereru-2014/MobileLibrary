require 'httparty'
module GoogleBooks

  class Search
    include HTTParty
    format :json

    KEY = "AIzaSyCv3lXTwMl2wUxHTH9MJFkMK4AVsjLfjCw"

    base_uri "https://www.googleapis.com/books/v1"

    attr_reader :title

    def initialize(args)
      @title = args[:title]


    end

    def self.find(title)
      response = get("/volumes", query: { q: title, key: KEY })

      books = []

      response["items"].each do |book|
        info = book.fetch("volumeInfo", {})
        image_links = info.fetch("imageLinks", { "thumbnail" => "http://placekitten.com/200/200"})
        books << {
          title: info["title"],
          author: info["authors"],
          thumbnail: image_links["thumbnail"]
        }
      end

      books
    end

  end


end
