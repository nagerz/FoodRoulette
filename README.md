# Food Roulette

Food Roulette is an app designed to help users decide where to eat, either alone or in a group. Users can ‘roulette’ to get a random restaurant selected for them from the Yelp API based on their location. They can also get a selection of three restaurants that they can send to their friends via text as a survey. Survey participants can then vote for a winner using text messaging and will be alerted when a winning restaurant is selected.

# Prerequisites	
- Requires PostgresSQL database

# Local Setup

Clone the project and enter the directory

	git clone https://github.com/csvlewis/foodroulette.git
	cd FoodRoulette

Bundle, migrate, and seed the database

	bundle
	rake db:{migrate, seed}

Launch redis and sidekiq in separate terminal windows

	redis-server
	bundle exec sidekiq

Launch a local server

	rails s

Install Figaro to create a config/application.yml file

	bundle exec figaro install

In order for the server to run locally, you will need keys from the [Yelp API](https://www.yelp.com/developers/v3/manage_app), [Google OAuth](https://console.developers.google.com/), [Twilio](https://www.twilio.com/try-twilio), and [Google Places API](https://developers.google.com/maps/documentation/javascript/get-api-key#step-1-get-an-api-key). The appropriate keys will go in your config/application.yml file under the following names:

	YELP_API_KEY: 
	GOOGLE_CLIENT_ID: 
	GOOGLE_CLIENT_SECRET: 
	TWILIO_ACCOUNT_SID: 
	TWILIO_AUTH_TOKEN: 
	TWILIO_PHONE_NUMBER: 
	GOOGLE_PLACES_API_KEY:
	API_URL: http://localhost:3000

The API_URL is needed for an internal api endpoint uri that is different in production.

# Site Functionality

When you visit the site for the first time, you will be asked to login by connecting to your Google account.

![Google OAuth Login Page](/images/OAuth.png?raw=true)

After doing so, you will be directed to the home page, where your browser may ask to use your current location. If you do so, that location will be used as your default location in searches. At any point, you can access the nav bar to return to the home page, view the site’s ‘About’ section, or visit your profile page which will keep track of your last few restaurant visits.

![Home Page](/images/Home.png?raw=true)

If you want a restaurant recommendation, you can type a location in the search bar and click ‘Roulette Now’. You will be taken to a new page where a selected restaurant is displayed.

![Roulette Now Page](/images/SingleRoulette.png?raw=true)

On this page you can see some basic information about the restaurant. From this page you can do a few things. You can click the name of the restaurant to open a tab with that restaurant’s Yelp page. You can click ‘Take Me There!’ to get Google Maps directions from your search location to the restaurant. Finally, you can click ‘Roulette Again’ to get another restaurant recommendation.

If you want to send out a group survey, you can go back to the main page, type a search location into the search bar and click “Survey Them!”

You will be taken to a new page where three selected restaurants are displayed. Each restaurant’s name is a link to that restaurant’s Yelp page, and you can click “Roulette Again” to get three new recommendations.

![Group Roulette Page](/images/GroupRoulette.png?raw=true)

If you click “Send to Friends”, you will be taken to a form where you can enter some information to create a survey. After entering your name, your friend’s phone numbers separated by commas, an event name, and an optional event time, a survey for the three restaurant recommendations will be sent out to each phone number that was entered.

![Survey Form Page](/images/SurveyForm.png?raw=true)

The user who created the survey will be presented with a page where they can vote for a restaurant in the survey.

![User Voting Page](/images/UserVote.png?raw=true)

Then they will be redirected to a survey results page where they can see the voting results for the survey updating as their friends submit votes.

![Survey Results Page (active)](/images/SurveyResultsActive.png?raw=true)

Each friend whose phone number was listed in the survey creation form will receive a text describing the restaurant voting options with directions on how to vote. After they respond with a 1, 2, or 3, they will receive a confirmation text with a link to the same voting results page that the user sees.

![Sample Voting Texts](/images/Text.png) <!-- .element height="50%" width="50%" -->

After all votes for the survey have been received or the original user manually ends the survey, the survey results page will update to show the winning restaurant.

![Survey Results Page (closed)](/images/SurveyResultsClosed.png?raw=true)

Each friend will also get a text message letting them know that the survey has ended and informing them of the winning restaurant.

# Testing

Sweater Weather uses RSpec for testing. To run the full test suite, run RSpec from the terminal.

        bundle exec rspec
        
Individual tests can be run by specifying the desired file path and line number. For example,

        bundle exec rspec spec/features/nav_bar_spec.rb:28
        
will run the item model test that is found in that file on line 28.

# Live Site

- https://calm-tundra-59037.herokuapp.com/

# Built Using
- Ruby on Rails
- PostgreSQL
- Redis
- Sidekiq
- HTML, CSS, JavaScript

# Created By
- [Chris Lewis](https://github.com/csvlewis)
