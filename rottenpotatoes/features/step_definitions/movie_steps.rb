# Add a declarative step here for populating the DB with movies.
value = 0
Given /the following movies exist/ do |movies_table|
  value = 0
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    value += 1
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  match1 = ((/#{e1}/) =~ page.body)
  match2 = ((/#{e2}/) =~ page.body)
  match1.should be < match2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.delete!("\"")
  rating_list.split(',').each do |field|
    uncheck.nil? ? check("ratings[" + field.strip + "]") : uncheck("ratings[" + field.strip + "]")
  end
end

Then(/^I should see all of the movies$/) do
  page.should have_css("table#movies tbody tr", count: value)
end