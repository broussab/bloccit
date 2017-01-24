require 'random_data'

50.times do
  Post.create!(
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

unique_post = Post.find_or_create_by!(
  title: "I'm a unique title!",
  body: 'with a unique body!'
)

Comment.find_or_create_by!(
  post: unique_post,
  body: "I'm a unique comment! Just look at me go!"
)

puts 'Seed finished'
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
