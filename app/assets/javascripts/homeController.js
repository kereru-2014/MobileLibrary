$(document).ready(function(){

 var HomeViewModel = function(){
    var self = this;
    self.books = ko.observableArray([]);
    $.getJSON("/api/v1/books/", function(data)
    {
      var initialData = ko.utils.arrayMap(data, function(book){
      return {not_fresh:true, id: book.id, title: book.title, author: book.author, ISBN: book.ISBN, lent_date: book.lent_date };
    })
      self.books(initialData);
    });

    self.addBook = function(){
      self.books.push({
        title:"",
        author:"",
        isbn:""
      });
    };


    self.save = function(){
      var book = self.books()[self.books().length -1]
      var request = {book:book};


         console.log(request,book);
      $.post('/api/v1/books', request, function(data){
      });
      self.books(initialData);
    };


  };



ko.applyBindings(new HomeViewModel());

// $("form").validate({submitHandler:HomeViewModel.save});
});




