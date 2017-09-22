# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_user = User.create( email: 'admin@myweb.com', password: '123456', confirmed_at: Time.now )
admin_user.add_role :admin
admin_user.save

test_user = User.create( email: 'test@myweb.com', password: '123456', confirmed_at: Time.now )
test_user.add_role :user
test_user.save
