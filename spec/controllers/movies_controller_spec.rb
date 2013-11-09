require 'spec_helper'

describe MoviesController do
  describe "GET similar" do
    context "when similar movie exists" do
      it "renders the similar template" do
        movie = FactoryGirl.create(:movie)
        FactoryGirl.create(:similar_movie)

        get :similar, id: movie.id
        expect(response).to render_template("similar")
      end
      it "assigns similar movies to @movies" do
        movie = FactoryGirl.create(:movie)
        similar_movie = FactoryGirl.create(:similar_movie)

        get :similar, id: movie.id
        expect(assigns(:movies)).to include(movie, similar_movie)
      end
    end

    context "when similar movie does not exist" do
      it "redirects to the home page" do
        movie = FactoryGirl.create(:movie)

        get :similar, id: movie.id
        expect(response).to redirect_to :root
      end
    end
  end
end