require('pry')
require_relative('../models/artist')
require_relative('../models/album')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({'name' => 'Bob Mitchell'})
artist1.save()

album1 = Album.new({'name' => 'ABC', 'genre' => 'bluegrass', 'artist_id' => artist1.id})
album1.save()

album2 = Album.new({'name' => '123', 'genre' => 'pop', 'artist_id' => artist1.id})
album2.save()

binding.pry
nil
