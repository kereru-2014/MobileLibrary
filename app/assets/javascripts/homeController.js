$(document).ready(function(){

 var HomeViewModel = function(){
    var self = this;
    self.books = ko.observableArray([]);
    $.getJSON("/api/v1/books/", function(data)
    {
      var initialData = ko.utils.arrayMap(data, function(book){
      return { id: book.id, title: book.title, author: book.author, isbn: book.ISBN, lent_date: book.lent_date };
    })
      self.books(initialData);
    });
  };



ko.applyBindings(new HomeViewModel());


});




