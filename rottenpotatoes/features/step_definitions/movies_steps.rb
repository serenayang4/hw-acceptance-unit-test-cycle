
Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |arg1, arg2|
  expect(Movie.find_by_title(arg1).director) == arg2
end

Then(/I should see "([^"]*)" before"([^"]*)"$/) do |arg1, arg2|
  /#{arg1}.*#{arg2}/ =~ page.body
end

When /I follow ("Find Movies With Same Director")$/ do |link|
  click_link "Find Movies With Same Director"
  expect(response.to render_template("search"))
end

Then /I should be on ("the Similar Movies page") for "([^"]*)"$/ do |search|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(search)
  else
    assert_equal path_to(search), current_path
  end
end

When /I destroy "([^"]*)"/ do |destroy|
  click_link "Destoy"
end