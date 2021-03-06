class Movie < ActiveRecord::Base
# the variable @all_ratings to be an enumerable collection of all possible values of a movie rating, such as ['G','PG','PG-13','R']. The controller method needs to set up this variable. And since the possible values of movie ratings are really the responsibility of the Movie model, it's best if the controller sets this variable by consulting the Model. Create a class method of Movie that returns an appropriate value for this collection.
  #asgn2.2
  def Movie.all_ratings #class method of Movie
    all_ratings = [] #local variable, valid only in this method
    Movie.all.each do |movie|
      all_ratings.push(movie.rating)
    end
    all_ratings = all_ratings.sort.uniq
  end
end
