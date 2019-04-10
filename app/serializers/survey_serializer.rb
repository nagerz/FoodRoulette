class SurveySerializer
  include FastJsonapi::ObjectSerializer
  attribute :total_votes do |survey|
    survey.votes.count
  end
  attribute :restaurant_1_votes do |survey|
    survey.survey_restaurants[0].votes.count unless survey.survey_restaurants.empty?
  end
  attribute :restaurant_2_votes do |survey|
    survey.survey_restaurants[1].votes.count unless survey.survey_restaurants.empty?
  end
  attribute :restaurant_3_votes do |survey|
    survey.survey_restaurants[2].votes.count unless survey.survey_restaurants.empty?
  end
end
