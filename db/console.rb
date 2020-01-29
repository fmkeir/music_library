require('pry')
require_relative('../models/artist')

artist1 = Artist.new({'name' => 'Bob Mitchell'})
artist1.save()

binding.pry
nil
