$(document).ready(function(){
  ko.applyBindings(new HomeViewModel());
  console.log("made it");
});

function getUserLibrary(callback){
  $.getJSON("/api/v1/books")
}
