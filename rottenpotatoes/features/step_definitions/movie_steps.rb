# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    puts "MOV: #{movie}"
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  puts "NSEEDS: #{n_seeds}"
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  puts e1
  puts e2
  puts page.body.index(e1)
  puts page.body.index(e2)
  expect(page.body.index(e1)).to be < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  puts "CHECK RATINGS STEP"
  # puts page.body

  # steps %Q{

  # }

  ratings = rating_list.split(", ")
  puts "LIST: #{ratings}"
  puts "CHECK: #{uncheck}"
  ratings.each do |rating|
    rating = "ratings_" + rating
    puts "RATING: #{rating}"
    if uncheck
      puts "UNCHECK"
      uncheck(rating)
    else
      puts "CHECK"
      check(rating)
    end
  end
end


# Then /I should see the following movies/ do


# Then /I should see all the movies with rating/ do |var|
# end

Then /I should (not )?see all the movies with ratings: (.*)/ do |filter, ratings|
  # Make sure that all the movies in the app are visible in the table
  puts "SEE MOVIES STEP"
  out = ["The Terminator", "When Harry Met Sally", "Amelie", "The Incredibles", "Raiders of the Lost Ark"]
  puts filter
  list = ratings.split(", ")
  puts list
  puts Movie.count
  movies = []
  list.each do |rating|
    # rating = "ratings_" + rating
    puts rating
    # puts Movie.where(rating: rating)
    movies += Movie.where(rating: rating)
  end
  # puts movies
  titles = []
  empty = []
  movies.each do |movie|
    # puts movie.title
    titles.append(movie.title)
  end

  puts titles.sort
  puts out.sort
  puts titles - out
  if filter
    expect(titles.sort-out.sort).not_to eq(empty)
  else
    expect(titles.sort).to eq(out.sort)
  end
end

Then /I should see every movie/ do
  puts "ALL THE MOVIES"
  puts Movie.count
  expect(Movie.count).to eq 10
end
