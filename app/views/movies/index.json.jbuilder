json.array!(@movies) do |movie|
  json.extract! movie, :title, :rating, :description, :release_date
  json.url movie_url(movie, format: :json)
end
