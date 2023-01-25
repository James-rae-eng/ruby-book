# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(:email => 'james@gmail.com', :password => 'password', :password_confirmation => 'password',
    :first_name => 'James', :last_name => 'Rae')

User.create!(:email => 'ocean@gmail.com', :password => 'password', :password_confirmation => 'password',
    :first_name => 'Ocean', :last_name => 'Leigh')

User.create!(:email => 'josh@gmail.com', :password => 'password', :password_confirmation => 'password',
    :first_name => 'Josh', :last_name => 'Brown')

User.create!(:email => 'guy@gmail.com', :password => 'password', :password_confirmation => 'password',
    :first_name => 'Guy', :last_name => 'Geeson')