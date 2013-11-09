FactoryGirl.define do
  factory :movie do
    title 'Aladdin'
    rating 'G'
    release_date '25-Nov-1992'
    director 'Ali Aliyev'
  end

  factory :similar_movie, class: Movie do
    title 'Another movie'
    rating 'PG'
    release_date '25-Nov-1990'
    director 'Ali Aliyev'
  end
end