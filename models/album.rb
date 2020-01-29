require('pg')
require_relative("../db/sql_runner")

class Album

  attr_accessor :name, :genre, :artist_id

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

  def update()
    sql = "UPDATE albums SET
    (name, genre, artist_id) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @genre, @artist_id, @id]
    results = SqlRunner.run(sql, values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    return Artist.new(results[0])
  end

  def delete()
    sql = "DELETE FROM album WHERE id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Album.new(results[0])
  end
end
