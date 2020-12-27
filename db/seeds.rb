# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create!(
  :name => "first",
  :email => "first@example.com",
  :password => "password",
)

user2 = User.create!(
  :name => "second",
  :email => "second@example.com",
  :password => "password",
)

user1.articles.create!(
  :title => "title1",
  :body => "body1",
  :status => "draft",
)

user2.articles.create!(
  :title => "title2",
  :body => "body2",
  :status => "draft",
)

# user1.articles.create!(
#   :title => "title3",
#   :body => "body3",
#   :status => "published",
# )

# user2.articles.create!(
#   :title => "title4",
#   :body => "body4",
#   :status => "published",
# )
