# RSVP System/Wedding Site

## Introduction

This is a little site we put together for our wedding reception. The code currently in this repository has been sanitized a bit to remove our information. I'm putting this here mostly for the tiny RSVP app contained within. I hope that it might be useful to at least one other person. We've got kind of a travel theme going on with the invites, which may be evident the "ticketing/check-in" nomenclature we're using here.

## Instructions and a word of warning

**WARNING:** *My dev chops are lacking, you won't need to look far to find sloppy code and hacks. It's also poorly documented. That being said, we ran this on Heroku for several months without incident.*

This site uses [Sinatra](http://www.sinatrarb.com/), a lightweight web app framework written in Ruby. You'll need to get that running in your environment, if it isn't already.

It also uses a database, which isn't unheard of, but not a standard Sinatra thing. This [Making a simple, database-driven website with sinatra and heroku](https://samuelstern.wordpress.com/2012/11/28/making-a-simple-database-driven-website-with-sinatra-and-heroku/) tutorial was a big help in getting the initial environment set up. If you are unfamiliar with using Sinatra with a database, it's worth a read.

### Things to Fix

Our information has been stripped out of the code in this repository. At minimum, you'll need to add your own information in the following places:

- Add your own content (images etc.) to views/index.erb
- Add your URL to the email links to views/email.erb
- Add your analytics code to views/analytics.erb
- The database
  - Add the values found in this migration 20150421032026_add_categories.rb
  - Data! You'll need your own party names etc. If you get this far and get stuck, let me know, I can help you.
- Rakefile: This is used to send email notifications, you'll need to put your email server information in there

### Environment Variables

There are several environment variables that need to be set in order for things to work at all (locally and on any other machine you wish this to run on).

Here's the list:

- PG_USER=[DB Username]
- PG_PASS=[DB Password]
- DATABASE_URL=[DB URL]
- AUTH_USER=[HTTP Auth User]
- AUTH_PASSWORD=[HTTP Auth Password]
- SMTP_PASSWORD=[Mail Password]
- SMTP_TO=[Return email address]
- NEW_RELIC_LICENSE_KEY=[New Relic License Key]
- LOG_TOKEN=[Log token]
