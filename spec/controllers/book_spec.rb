require "rails_helper"

RSpec.describe BooksController do

#--------------------------------------#
#          The #get index action       #
#--------------------------------------#

  describe "GET index" do
    before do
      @book = Fabricate(:book)
      get :index
    end

    it "is successful" do
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

#--------------------------------------#
#          The #create action          #
#--------------------------------------#

  describe  "POST create" do
    before do
      @valid_attrs = Fabricate.attributes_for(:book)
    end

    it "is successful" do
      post :create, { book: @valid_attrs }
      expect(response).to be_redirect
    end

    it "adds one to the total number of books" do
      expect { post :create, { book: @valid_attrs } }.to change(Book, :count).by(1)
      expect(response).to be_redirect
    end

    it "redirects to the correct url" do
      post :create, { book: @valid_attrs }
      expect(response).to redirect_to root_url
    end
  end

#--------------------------------------#
#          The #show action            #
#--------------------------------------#

  describe "GET show" do
    before do
      @book = Fabricate(:book, id: 1)
      get :show, id: 1
    end

    it "is successful" do
      expect(response).to be_success
    end

    it 'returns the specified item' do
      expect(json["id"]).to eq(@book.id)
    end

    it "checks if the JSON object contains a 'title' key" do
      expect(json).to have_key('title')
    end

    it "expects that the firsts books title has the name fabricated" do
      expect(json["title"]).to eq(@book.title)
    end
  end

#--------------------------------------#
#          The #edit action            #
#--------------------------------------#

  describe "EDIT update" do
    let(:book){Fabricate(:book, id: 1)}
    before do
      get :edit, :id => book.id
    end

    it "is successful" do
      expect(response).to be_success
    end

    it 'returns the specified item' do
      expect(json["id"]).to eq(book.id)
    end

    it "expects that the books title has the name fabricated" do
      expect(json["title"]).to eq(book.title)
    end
  end

#--------------------------------------#
#          The #update action          #
#--------------------------------------#

  describe "PATCH update" do
    let!(:book){Fabricate(:book, id: 1)}
    before do
      patch :update, :id => book.id, :book => {:title => "yo"}
    end

    it "is successful" do
      expect(response).to be_redirect
    end

    it 'returns the specified item' do
      expect(json["id"]).to eq(@book.id)
    end
  end

#--------------------------------------#
#         The #delete action           #
#--------------------------------------#

  describe "DELETE destroy" do
    let(:book){Fabricate(:book, id: 1)}
    before do
      patch :update, :id => book.id
    end

    xit "is successful" do
      expect(response).to be_success
    end

    xit 'returns the specified item' do
      expect(json["id"]).to eq(@book.id)
    end
  end
end
