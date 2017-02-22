5.times do
  pw = Faker::Internet.password
  un = Faker::GameOfThrones.character.gsub(/\W/, "")
  User.create!(
    username: un,
    email: "#{un}@blocipedia.com",
    password: pw,
    password_confirmation: pw
  )
end

users = User.all

20.times do
  Wiki.create!(
    title: Faker::Hacker.say_something_smart,
    body: "### Section 1\n#{Faker::Hipster.paragraph}\n#### Sub A\n#{Faker::Hipster.paragraph}\n> #{Faker::StarWars.quote}\n- #{Faker::StarWars.character}\n\n### Section 2\n#{Faker::Hipster.paragraph}",
    private: false,
    user: users.sample
  )
end

User.create!(
  email: "dlively@resurgens.io",
  username: "dlively",
  password: "password",
  password_confirmation: "password",
  role: :admin
)

User.create!(
  email: "standard@resurgens.io",
  username: "standard",
  password: "password",
  password_confirmation: "password"
)

puts "Seed complete"
puts "#{User.count} created"
puts "#{Wiki.count} created"
