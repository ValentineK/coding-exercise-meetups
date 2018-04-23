# README

The exercise is to build a Ruby-on-rails application that will let users to search for meetups in Munich.

## Setup

if you wold like have caching enabled in development mode you need to have `tmp/caching-dev.txt` file with any or none content.

in development or production mode you will need to have env var MEETUP_API_KEY which you can obtain at https://secure.meetup.com/meetup_api/key/ 

in production mode you will probably need to run `rake assets:precompile` to
 Compile the assets an you will need to have env var RAILS_SERVE_STATIC_FILES
  enabled in case if RoR will serve assets (nat Apache or nginx)

## Features
* User is able to visit the homepage of the app and enter a query `text` in a search bar
to search for meetups in Munich (hardcoded).
  * Once the user submits the search query `text`, it is used to get the matching meetup groups from Meetups API.
* The user is presented with a list of meetups that matched their query.
  * Can be just a single page table with top 10 matches without any pagination.
  * Show the meetup's `thumbnail photo`, `name`, `location`, `status`, `category`.
* User is able to click on the meetup's name to see the `past` events from that meetup.
  * Display of the upcoming events happens on the same page without a reload.
  * Event details are fetched from Meetups API and are displayed next or under the meetup row or in an overlay.
  However you feel comfortable.
  * Event list should show 3 most recent `past` events organised by this meetup group.
  * Show events' `date and time`, `venue's name`, `yes rsvp count`.
* User can enter new query text in the search field and search for new meetups again.
