require 'factory_bot_rails'
require 'faker'

include FactoryBot::Syntax::Methods

User.destroy_all
Restaurant.destroy_all
Survey.destroy_all
Visit.destroy_all
SurveyRestaurant.destroy_all
Vote.destroy_all

user_1 = create(:user,
                google_id: Faker::IDNumber.unique.south_african_id_number.to_i,
                first_name: Faker::Creature::Dog.name,
                last_name: Faker::Creature::Dog.sound,
                email: Faker::Internet.unique.email,
                token: Faker::IDNumber.unique.spanish_citizen_number,
                refresh_token: Faker::IDNumber.unique.spanish_foreign_citizen_number,
                thumbnail: "https://upload.wikimedia.org/wikipedia/commons/6/67/User_Avatar.png"
              )
user_2 = create(:user,
                google_id: Faker::IDNumber.unique.south_african_id_number.to_i,
                first_name: Faker::Creature::Dog.name,
                last_name: Faker::Creature::Dog.sound,
                email: Faker::Internet.unique.email,
                token: Faker::IDNumber.unique.spanish_citizen_number,
                refresh_token: Faker::IDNumber.unique.spanish_foreign_citizen_number,
                thumbnail: "https://upload.wikimedia.org/wikipedia/commons/6/67/User_Avatar.png"
              )
user_3 = create(:user,
                google_id: Faker::IDNumber.unique.south_african_id_number.to_i,
                first_name: Faker::Creature::Dog.name,
                last_name: Faker::Creature::Dog.sound,
                email: Faker::Internet.unique.email,
                token: Faker::IDNumber.unique.spanish_citizen_number,
                refresh_token: Faker::IDNumber.unique.spanish_foreign_citizen_number,
                thumbnail: "https://upload.wikimedia.org/wikipedia/commons/6/67/User_Avatar.png"
              )
user_4 = create(:user,
                google_id: Faker::IDNumber.unique.south_african_id_number.to_i,
                first_name: Faker::Creature::Dog.name,
                last_name: Faker::Creature::Dog.sound,
                email: Faker::Internet.unique.email,
                token: Faker::IDNumber.unique.spanish_citizen_number,
                refresh_token: Faker::IDNumber.unique.spanish_foreign_citizen_number,
                thumbnail: "https://upload.wikimedia.org/wikipedia/commons/6/67/User_Avatar.png"
              )
user_5 = create(:user,
                google_id: Faker::IDNumber.unique.south_african_id_number.to_i,
                first_name: Faker::Creature::Dog.name,
                last_name: Faker::Creature::Dog.sound,
                email: Faker::Internet.unique.email,
                token: Faker::IDNumber.unique.spanish_citizen_number,
                refresh_token: Faker::IDNumber.unique.spanish_foreign_citizen_number,
                thumbnail: "https://upload.wikimedia.org/wikipedia/commons/6/67/User_Avatar.png"
              )

restaurant_1 = create(:restaurant,
                      name: Faker::Food.dish,
                      latitude: Faker::Number.decimal(2, 12),
                      longitude: Faker::Number.decimal(2, 12),
                      rating: Faker::Number.decimal(1),
                      category_1: Faker::Food.spice
                      )
restaurant_2 = create(:restaurant,
                      name: Faker::Food.dish,
                      latitude: Faker::Number.decimal(2, 12),
                      longitude: Faker::Number.decimal(2, 12),
                      rating: Faker::Number.decimal(1),
                      category_1: Faker::Food.spice
                      )
restaurant_3 = create(:restaurant,
                      name: Faker::Food.dish,
                      latitude: Faker::Number.decimal(2, 12),
                      longitude: Faker::Number.decimal(2, 12),
                      rating: Faker::Number.decimal(1),
                      category_1: Faker::Food.spice
                      )
restaurant_4 = create(:restaurant,
                      name: Faker::Food.dish,
                      latitude: Faker::Number.decimal(2, 12),
                      longitude: Faker::Number.decimal(2, 12),
                      rating: Faker::Number.decimal(1),
                      category_1: Faker::Food.spice
                      )
restaurant_5 = create(:restaurant,
                      name: Faker::Food.dish,
                      latitude: Faker::Number.decimal(2, 12),
                      longitude: Faker::Number.decimal(2, 12),
                      rating: Faker::Number.decimal(1),
                      category_1: Faker::Food.spice
                      )
restaurant_6 = create(:restaurant,
                      name: Faker::Food.dish,
                      latitude: Faker::Number.decimal(2, 12),
                      longitude: Faker::Number.decimal(2, 12),
                      rating: Faker::Number.decimal(1),
                      category_1: Faker::Food.spice
                      )

survey_1 = create(:survey, user: user_1, phone_numbers: "[123, 456, 789]")
survey_2 = create(:survey, user: user_2, phone_numbers: "[098, 765, 432]")
survey_3 = create(:survey, user: user_3, phone_numbers: "[333, 777, 222]")

survey_4, survey_5, survey_6 = create_list(:survey, 3, user: user_4, phone_numbers: "[111, 666, 890, 4567]")

survey_restaurant_1 = create(:survey_restaurant, survey: survey_1, restaurant: restaurant_1, rank: 1)
survey_restaurant_2 = create(:survey_restaurant, survey: survey_1, restaurant: restaurant_2, rank: 1)
survey_restaurant_3 = create(:survey_restaurant, survey: survey_1, restaurant: restaurant_3, rank: 1)
survey_restaurant_4 = create(:survey_restaurant, survey: survey_4, restaurant: restaurant_4, rank: 1)
survey_restaurant_5 = create(:survey_restaurant, survey: survey_5, restaurant: restaurant_5, rank: 1)
survey_restaurant_6 = create(:survey_restaurant, survey: survey_6, restaurant: restaurant_6, rank: 1)

visit_1 = create(:visit, user: user_1, restaurant: restaurant_1)

vote_1 = create(:vote, survey_restaurant: survey_restaurant_1, value: 1, voter: 123)
vote_2 = create(:vote, survey_restaurant: survey_restaurant_2, value: 2, voter: 456)
vote_3 = create(:vote, survey_restaurant: survey_restaurant_3, value: 3, voter: 789)
vote_4 = create(:vote, survey_restaurant: survey_restaurant_2, value: 1)
vote_5 = create(:vote, survey_restaurant: survey_restaurant_3, value: 1)


puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Restaurants created: #{Restaurant.count.to_i}"
puts "Surveys created: #{Survey.count.to_i}"
puts "Visits created: #{Visit.count.to_i}"
puts "Survey Restaurants created: #{SurveyRestaurant.count.to_i}"
puts "Votes created: #{Vote.count.to_i}"
