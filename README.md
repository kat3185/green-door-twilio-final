# green-door-twilio-final
This app was written for Green Door Labs.  It allows those playing Green Door Labs games to text a phone number and get back the address to visit to start their game.  It is a Sinatra app, designed to be deployed on Heroku and interface with the Twilio API.

Users will send a text to a twilio number, and twilio then redirects the text to /sms-green-door (this is set up on the twilio website).  This app then checks its database for games with a short_title that includes the body of the text message (not case sensitive).

Based on how many games it find with the body of the text included in the short title, it will determine how to respond to the text, and send that response back to the twilio api, which will then reply with an SMS containing the response.
