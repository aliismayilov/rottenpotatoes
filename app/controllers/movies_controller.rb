class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :similar]

  # GET /movies
  # GET /movies.json
  def index
    if params[:sort]
      session[:sort] = params[:sort]
    end

    if params[:ratings]
      session[:ratings] = params[:ratings]
    else
      if session[:ratings]
        redirect_to movies_path(Hash[session[:ratings].map { |k, v| ["ratings[#{k}]", v]}])
      else
        session[:ratings] = Hash[Movie.all_ratings.map {|r| [r, 1]}]
      end
    end

    @movies = Movie.all
    @movies = Movie.order session[:sort]
    @movies = @movies.where(rating: session[:ratings].keys)
    @all_ratings = Movie.all_ratings
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render action: 'show', status: :created, location: @movie }
      else
        format.html { render action: 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

  def similar
    @movies = @movie.similar_movies

    if @movies
      render "similar"
    else
      redirect_to :root, notice: "'#{@movie.title}' has no director info"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
    end
end
