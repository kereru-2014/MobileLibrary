require "rails_helper"

RSpec.describe BooksController do

  describe "GET index" do
    before do
      @book = Fabricate(:book)
      get :index
    end

    it "recieves a status 200 message when the api is called" do
      expect(response).to be_success
    end

    it "displays an array containing one book in JSON format" do
      expect(json.length).to eq(1)
    end

    it "checks if the JSON object contains a 'title' key" do
      expect(json.first).to have_key('title')
    end

    it "expects that the firsts books title has the name fabricated" do
      expect(json.first["title"]).to eq(@book.title)
    end
  end

  describe  "POST create" do
    before do
      @new_book = Fabricate(:book)
      # @Books = Book.new
    end

    it "receives a status 200 message when the api is called" do
      expect(response).to be_success
    end


    # it "adds one to the total number of books" do
    #   # expect { post :create, :book => new_book }.to change @Books.length.to eq(1)
    #   expect book.length to eq(1)
    # end
  end

  describe "GET show" do
    let(:book) {create(:book)}

   it "receives a status 200 message when the api is called" do
      get :book, id: book, format: :json
      expect(response).to be_success
    end


  end

end
