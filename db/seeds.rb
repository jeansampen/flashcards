require 'faker'

tag_names = ['Astronomy', 'Chicago', 'Spring', 'Tech', 'Watermelon', 'Coffee', 'Puppies', 'WickerPark', 'Kittens', 'Philosoraptor']

# tags.each do |tag|
#   Tag.create(text: tag)
# end

10.times do |i|
  entry = Entry.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph(10), user_id: (i + 1))
  a_tag = tag_names[i]
  entry.tags.create(text: a_tag)
end

10.times do |i|
  User.create(full_name: Faker::Name.name, username: "user#{i + 1}", password: "password")
end





