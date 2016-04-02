Given /the following movies exist/ do |movies_table|
    movies_table.hashes.each do |movie|
        Movie.create!(movie)
    end
end 
Then /the director of "(.*)" should be "(.*)"/ do |title, director|
   page.should have_content(title)
   page.should have_content(director)
end
