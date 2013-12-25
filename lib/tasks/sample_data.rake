namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_entries
    make_comments
    make_relationships    
  end
end

def make_users
  User.create!(name: "test",
                 email: "test@railstutorial.org",
                 password: "123456",
                 password_confirmation: "123456")
    10.times do |n|
      name  = Faker::Name.name
      email = "test-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
end

def make_entries
  users = User.all(limit: 9)
    10.times do |n|
      title = "test-#{n+1}title."
      body = Faker::Lorem.sentence(5)
      users.each { |user| user.entries.create!(title: title, body: body)}
    end
end

def make_comments
  entries = Entry.all(limit:9)
  user = User.first
  5.times do |n|
    content = "content-#{n+1} this is comment"
    entries.each { |entry| entry.comments.create!(content: content, user_id_cmt: user.id) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..8]
  followers      = users[3..9]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end