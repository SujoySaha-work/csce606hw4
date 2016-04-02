FactoryGirl.define do
  factory :movie do
    title "A fake title"
    director "A fake director"
    rating 'PG'
    release_date (10.year.ago)
  end 
end