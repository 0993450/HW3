class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default

  end

  def index
    @movies = Movie.all
    #soted_by
    sort_by = params[:sort_by]
    case sort_by
    when 'title'
      ordering,@title_header = {:title => :asc}
    when 'release_date'
      ordering,@date_header = {:release_date => :asc}
    end

    if sort_by.blank? == false
      @movies = Movie.order(ordering)
    end 

    #all_ratings
    @all_ratings = Movie.all_ratings
    @checked_ratings = {}
    if params[:ratings].blank? == false
      @checked_ratings = params[:ratings].keys
      @movies = Movie.where(rating: @checked_ratings)
    end
  end

  def new
    # default: render 'new' template
  end


  def create
    params.permit!
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    params.permit!
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
