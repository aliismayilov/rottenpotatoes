class Movie < ActiveRecord::Base

  def self.all_ratings
    Movie.uniq.pluck(:rating)
  end

  def similar_movies
    if self.director
      movies = Movie.where director: self.director
      if movies.count > 1
        movies
      end
    end
  end
end
