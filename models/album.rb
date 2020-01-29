require('pg')
require_relative("../db/sql_runner")

class Album

  attr_reader :name, :genre, :artist_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @genre = options["genre"]
    @artist_id = options["artist_id"].to_i
  end

  def save()
    sql = "INSERT INTO albums
    (name, genre, artist_id)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@name, @genre, @artist_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i()
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_data = results[0]
    artist = Artist.new(artist_data)
    return artist
  end

  def self.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end

end
