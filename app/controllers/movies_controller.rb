class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #asgn.1.b.
    #asgn2.2
    @all_ratings = Movie.all_ratings
    sortby = params[:order]
    filterby = params[:ratings] #|| {} #so no nil case
    if filterby == nil
      @filterby = @all_ratings
    else
      @filterby = filterby.keys
    end
    #@filterby = @filterby.keys || @all_ratings #so no nil case
    #@filterby = @all_ratings
    if sortby == 'movies.title' 
      @titlestyle = 'hilite'
    elsif sortby == 'movies.release_date'
      @datestyle = 'hilite'
    end
    #given and modified
    @movies = Movie.where(:rating => @filterby).find(:all, :order => sortby) # || []
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
