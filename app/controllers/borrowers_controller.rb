class BorrowersController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_filter  :verify_authenticity_token

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
      "created_at": "2014-09-30T21:46:48.253Z",
      "updated_at": "2014-09-30T21:46:48.253Z",
      "user_id": 1
    },
   {
      "id": 2
      "name": "Serena Wood",
      "email": "test2@test.com",
      "phone_number":  "0807609560",
      "created_at": "2014-09-30T21:42:43.551Z",
      "updated_at": "2014-09-30T21:42:43.551Z",
      "user_id": 1
    },
  ]'

  def index
    borrowers = current_user.borrowers.alphabetically
    render json: borrowers
  end

#--------------------------------------#
#          The #create action          #
#--------------------------------------#
  api :POST, '/v1/borrowers', "Add a borrower using JSON"
  formats ['json']
  description "Use the create api to add a new borrower/contact to the database, the JSON will be expected to look like the example.
  The JSON will be sent back to confirm persitance or show errors during persistance"
  example '{
  {
    "name": "Bob Smith",
    "email": "test@test.com",
    "phone_number":  "0807609560",
    },
  }'

  def create
    @borrower = current_user.borrowers.build(borrower_params)
    if @borrower.save
    render json: @borrower
    end
  end

#--------------------------------------#
#          The #show action            #
#--------------------------------------#


  api :GET, 'api/v1/borrowers/:id', "Find a borrower by id "
  param :id, String, :desc => "Name of borrower", :required => true
  description "Find a borrower by borrower_name, the borrower will be returned in a json format as shown in the example"
  example '{
      "id": 5,
      "name": "Bob Smith",
      "email": "test@test.com",
      "phone_number":  0807609560,
      "created_at": "2014-09-27T06:15:31.127Z",
      "updated_at": "2014-09-27T06:15:31.127Z",
      "user_id": 1
    }'

  def show
    @borrower = current_user.borrowers.find(params[:id])
    render json: @borrower
  end

#--------------------------------------#
#          The #edit/show action       #
#--------------------------------------#

  api :GET, 'api/v1/borrowers/:id/edit', "Find borrower by name and receive JSON to edit"
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
      "user_id": 1
  }'

  def edit
    render json: current_user.borrowers.find(params[:id])
  end

#--------------------------------------#
#         The #delete action           #
#--------------------------------------#

  api :DELETE, 'api/v1/borrowers/:id', "Delete a borrower of given id"
  param :id, String, :desc => "Id of borrower", :required => true
  description "Select a borrower by their Id to remove them from the library"

  def destroy
    current_user.borrowers.find(params[:id]).destroy
    head :accepted
  end

#-------------------------------------#
# Dealing with Rails strong params    #
#-------------------------------------#

private
  def borrower_params
    params.require(:borrower).permit(:name, :email, :phone_number)
  end
end
