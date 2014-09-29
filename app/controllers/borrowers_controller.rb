class BorrowersController < ApplicationController
  protect_from_forgery with: :exception

# v1/books_controller.rb

#--------------------------------------#
#          The #get index action       #
#--------------------------------------#

  api :GET, 'api/v1/borrowers', "Get all borrowers"
  formats ['JSON']
  description "Get a list of all borrowers."
  example '[
    {
      "id": 1
      "name": "Bob Smith",
      "email": "test@test.com",
      "phone_number":  "0807609560",
    },
   {
      "id": 2
      "name": "Serena Wood",
      "email": "test2@test.com",
      "phone_number":  "0807609560",
    },
  ]'

  def index
    render json: Borrower.all
  end

#--------------------------------------#
#          The #create action          #
#-----------------------
  api :POST, '/v1/borrowers', "Add a borrower using JSON"
  formats ['json']
  description "Use the create api to add a new borrower/contact to the database, the JSON will be expected to look like the example.
  The JSON will be sent back to confirm persitance or show errors during persistance"
  example '{
  {
    "name": "Bob Smith",
    "email": "test@test.com",
    "phone_number":  "0807609560",
      "name": "Bob Smith",
      "email": "test@test.com",
      "phone_number":  "0807609560",
    },
  }'

  def create
    @borrower = Borrower.create!(borrower_params)
    if @borrower.save
      #GF to discuss redirect_to lend_url
    else
      render json: @borrower
    end
  end

#--------------------------------------#
#          The #show action            #
#--------------------------------------#


  api :GET, 'api/v1/borrowers/:name', "Find a borrower by name "
  param :id, String, :desc => "Name of borrower", :required => true
  description "Find a borrower by borrower_name, the borrower will be returned in a json format as shown in the example"
  example '{
      "name": "Bob Smith",
      "email": "test@test.com",
      "phone_number":  0807609560,
      "created_at": "2014-09-27T06:15:31.127Z",
      "updated_at": "2014-09-27T06:15:31.127Z",
    }'

  def show(searched_name)
    @borrower = Borrower.find_by name: searched_name
    puts @borrower.id
    # render json: Borrower.find(params[:name])
    render json: @borrower

#--------------------------------------#
#          The #edit action            #
#--------------------------------------#

  api :EDIT, 'api/v1/borrower/:id/edit', "Find borrower by name and receive JSON to edit"
  param :id, String, :desc => "Id of borrower", :required => true
  description "Find a borrower by name to find the borrower id, the borrower will be returned in a json format as shown in the example for editting"
  example '{
      "id": 1,
      "name": "Bob Smith",
      "email": "test@test.com",
      "phone_number":  "0807609560",
      "book_id": null,
      "created_at": "2014-09-27T06:15:31.127Z",
      "updated_at": "2014-09-27T06:15:31.127Z",
  }'

  def edit
    render json: Borrower.find(params[:id])
  end

#--------------------------------------#
#         The #delete action           #
#--------------------------------------#

  def destroy
    Borrower.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

#-------------------------------------#
# Dealing with Rails strong params    #
#-------------------------------------#

private
  def borrower_params
    params.require(:borrower).permit(:name, :email, :phone_number)

end
