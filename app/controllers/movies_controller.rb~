class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings #instance var used in the view

    #filter by ratings: default/initially is ALL
    if params[:ratings] == nil #if no checkboxes clicked, no filter
      @filterby = @all_ratings
    else #if checkboxes clicked, filter by ratings
      @filterby = params[:ratings].keys 
    end

    #sort by order: default is sort by DB id #
    #set style of sorted list header
    if params[:order] == 'movies.title' 
      @titlestyle = 'hilite'
    elsif params[:order] == 'movies.release_date'
      @datestyle = 'hilite'
    end

    #sort and filter list of movies for the view
    @movies = Movie.where(:rating => @filterby).find(:all, :order => params[:order])

    #save/update the session
    save_session
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

#got this idea from https://github.com/twalker/hw2_rottenpotatoes/blob/master/app/controllers/movies_controller.rb
  def save_session
    #first page visit, initialize custom hash
    if session[:custom] == nil
      session[:custom] = {}
    end
    #if session is not holding current settings, 
    #set correct settings and redirect; add the customizations in
    #the session to the URI path on the index page. By passing
    #movies_path a hash, params[] will be updated (& what you see 
    #in the URI). This will go through afer every new customization.
    if session[:custom][:order] != params[:order] || session[:custom][:ratings] != params[:ratings]
       #if user deselected all ratings, don't save over the session;
       #reuse previous selections instead
        set_session_parameter(:order)
        set_session_parameter(:ratings)
        redirect_to movies_path(session[:custom])
    end
  end

  def set_session_parameter(par)
    if params[par] != nil
      session[:custom][par] = params[par]
    end
  end
#If the user explicitly includes new sorting/filtering settings in params[], the values stored in the session should not override them. On the contrary, the new settings should be remembered in the session. 

end
