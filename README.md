# green-door-twilio-final
This app was written for Green Door Labs.  It allows those playing Green Door Labs games to text a phone number and get back the web address to visit to start their game.  It is a Sinatra app, designed to be deployed on Heroku and interface with the Twilio API.

Users will send a text to a Twilio number, and Twilio then redirects the text to /sms-green-door (this is specified on the Twilio website).  This app then checks its database for games with a short_title that includes the body of the text message (not case sensitive).

Based on how many games it find with the body of the text included in the short title, it will determine how to respond to the text (see the sms.rb file in app > models), and send that response back to the Twilio API, which will then reply with an SMS containing the response.

To run this app locally, clone the repo and ensure Ruby is installed.  In the project directory, run "gem install bundler", then "bundle install", then "rake db:create && rake db:migrate".  Then run "Ruby app.rb", and the app will start running on localhost port 4567.  Since Twilio will not be set up, you will unfortunately not be able to interact with the Twilio API locally.
