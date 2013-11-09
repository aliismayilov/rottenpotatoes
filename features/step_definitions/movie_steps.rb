Given /^the following movies exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  # pending # express the regexp above with the code you wish you had
  table.rows.each do |row|
    Movie.create! title: row[0], rating: row[1], director: row[2], release_date: row[3]
  end
end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |movie_title, director|
  movie = Movie.find_by title: movie_title
  movie.director.should == director
end