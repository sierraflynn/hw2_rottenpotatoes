class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings #used in the view

    #filter by ratings: default is ALL
    if params[:ratings] == nil #if no checkboxes clicked, no filter
      @filterby = @all_ratings
    else #if checkboxes clicked, filter by ratings
      @filterby = params[:ratings].keys 
    end

    #sort by order: default is none (by DB id #)
    if params[:order] == 'movies.title' 
      @titlestyle = 'hilite'
    elsif params[:order] == 'movies.release_date'
      @datestyle = 'hilite'
    end

    #sort and filter list of movies for the view
    @movies = Movie.where(:rating => @filterby).find(:all, :order => params[:order])

    ensure_table_filters
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

#testing!!!
#https://github.com/twalker/hw2_rottenpotatoes/blob/master/app/controllers/movies_controller.rb
  private
  def ensure_table_filters
    session[:custom] = {} if session[:custom].nil?
    if params[:order] != session[:custom][:order] || params[:ratings] != session[:custom][:ratings]
      needs_redirect = true
    end
    session[:custom][:order] = params[:order] unless params[:order].nil?
    session[:custom][:ratings] = params[:ratings] unless params[:ratings].nil?
    redirect_to movies_path(session[:custom]) if needs_redirect
  end

  def blah
    #determine session's custom settings
    if session[:custom] == nil #initialize
      session[:custom] = {}
    end
    #if session is not holding current settings, 
    #redirect and set correct settings if needed
    if session[:custom][:order] != params[:order] || session[:custom][:ratings] != params[:ratings]
      if session[:custom][:order] != nil
        session[:custom][:order] = params[:order]
      end
      if session[:custom][:ratings] != nil
        session[:custom][:ratings] = params[:ratings]
      end
      redirect_to movies_path(session[:custom])
    end
  end

end
