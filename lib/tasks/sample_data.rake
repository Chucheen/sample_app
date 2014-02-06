namespace :db do
  desc 'Fill database with sample data'

  task populate_users: :environment do

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@hotmail.com"
      password = 'password'
      User.create!(
        name: name,
        email: email,
        password: password,
        password_confirmation: password
      )
    end
  end

  task populate_microposts: :environment do
    users = User.all(limit:6)
    50.times do
      users.each do |user|
        user.microposts.create!(content: Faker::Lorem.sentence(10))
      end
    end

  end

  task populate_followers: :environment do
    users = User.all
    user = User.first
    followers = users[4..20]
    followed = users[0..40]
    followers.each { |follower|
      follower.follow! user unless follower.following? user
    }
    followed.each {|followed|
      user.follow! followed unless user.following? followed
    }
  end
end
