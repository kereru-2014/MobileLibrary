require "rails_helper"

RSpec.describe BooksController do

  before do
    sign_in Fabricate(:user)
  end

#--------------------------------------#
#          The #get index action       #
#--------------------------------------#

  describe "GET index" do
    before do
      @book = Fabricate(:book)
      sign_in @book.user
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
      expect(response).to be_success
    end

    it "adds one to the total number of books" do
      expect { post :create, { book: @valid_attrs } }.to change(Book, :count).by(1)
      expect(response).to be_success
    end
  end

#--------------------------------------#
#          The #show action            #
#--------------------------------------#

  describe "GET show" do
    before do
      @book = Fabricate(:book, id: 1, title: "Far Far Away")
      sign_in @book.user
    end

    it "is successful" do
      get :show, { id: @book.id}
      expect(response).to be_success
    end

    it 'returns the specified book id' do
      expect(@book.id).to eq(1)
    end

    it "checks if the book contains a 'title' expected" do
      expect(@book.title).to eq("Far Far Away")
    end
  end

#--------------------------------------#
#          The #edit action            #
#--------------------------------------#

  describe "EDIT update" do
    before do
      @book = Fabricate(:book, id: 1, title: "Far Far Away")
      sign_in @book.user
    end

    it "is successful" do
      get :edit, { id: @book.id}
      expect(response).to be_success
    end

    it 'returns the specified book id' do
      expect(@book.id).to eq(1)
    end

    it "checks if the book contains a 'title' expected" do
      expect(@book.title).to eq("Far Far Away")
    end
  end

#--------------------------------------#
#          The #update action          #
#--------------------------------------#

  describe "PATCH update" do

    before do
      @book = Fabricate(:book, id: 1)
      sign_in @book.user
      patch :update, :id => @book.id, :book => {:title => "yo"}
    end

    it "is successful" do
      expect(response).to be_success
    end

    it 'returns the specified item' do
      expect(json["id"]).to eq(@book.id)
    end
  end

#--------------------------------------#
#         The #delete action           #
#--------------------------------------#

  describe "DELETE destroy" do

    before do
     @book = Fabricate(:book, id: 1)
     sign_in @book.user
    end

    it "is successful" do
      expect(response).to be_success
    end

    it 'deletes the specified book' do
      expect { delete :destroy, {id: @book.id } }.to change(Book, :count).by(-1)
    end
  end

end
