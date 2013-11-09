require 'spec_helper'

describe Movie do
  describe "#find_similar" do
    let(:movie) { FactoryGirl.create :movie }

    it "returns nil when director field is empty" do
      movie.director = nil
      movie.save

      expect(movie.similar_movies).to be_nil
    end

    context "when there is similar movie" do
      it "includes the movies with the same director" do
        similar_movie = FactoryGirl.create :similar_movie
        expect(movie.similar_movies).to include(movie, similar_movie)
      end
    end
    context "when there is no similar movie" do
      it "returns nil" do
        expect(movie.similar_movies).to be_nil
      end
    end
  end
end