# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Book.destroy_all
User.destroy_all

25.times { Fabricate(:book)}
10.times { Fabricate(:borrower)}


Book.create(borrower_id: 3, image_url:"http://static.comicvine.com/uploads/scale_small/0/787/112963-18529-108836-1-neil-gaiman-s-neverw.jpg")
Book.create(borrower_id: 2, image_url:"http://static.comicvine.com/uploads/scale_small/0/787/112963-18529-108836-1-neil-gaiman-s-neverw.jpg")
Book.create(borrower_id: 1, image_url:"http://static.comicvine.com/uploads/scale_small/0/787/112963-18529-108836-1-neil-gaiman-s-neverw.jpg")



