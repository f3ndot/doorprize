doorprize
=========

[![Build Status](https://travis-ci.org/f3ndot/doorprize.png)](https://travis-ci.org/f3ndot/doorprize)

A Rails site where cyclists who were "doored" can report their incident for statistics in Canada

Currently using the [MIT license](LICENSE) for the project.

### Live Developers Playground / Testing Environment ###

Take a stab! It's located at __[dev.doored.ca](http://dev.doored.ca/)__

Why?
----

Because, back in 2012, the Toronto police redefined what a "collision" is, and apparently that's a good enough reason to discontinue tracking "dooring" incidents.[1]

Because the police won't track dooring until they're ordered to do so.[2]

Because despite the fact that the Police board wants Toronto cops to review the policy, It'll take the Toronto Police 3 months to respond.[3] I can build a reporting database application in just 1/6 of that time.

Because I feel it's important to track and record something that's an issue in this community. By not tracking these incidents, how can we even begin adequately address the issue?


Developer Collaboration
-----------------------

### Application Details ###

- Ruby on Rails 4 framework
- Developed with Ruby 2.0.0
- Using HTML5, CSS, CoffeeScript, LESS for front-end
- Database *probably* will be Postgres
- Considering Heroku or Linode for hosting

### Local Application Installation ###

*This is very much a __TODO__ part of the README. Assumes you have ruby 2 and bundler*

1. Clone the source to your computer

   ```
   git clone git@github.com:f3ndot/doorprize.git
   ```

2. Run bundler

   ```
   bundle install
   ```

3. Export the required environment variables:

   ```bash
   export DOORED_SECRET_TOKEN_KEY=deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
   export DOORED_DEVISE_PEPPER=deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
   ```

   The following environment variables are expected in staging and production:

   ```bash
   DOORED_SECRET_TOKEN_KEY
   DOORED_DEVISE_PEPPER
   SENDGRID_USERNAME
   SENDGRID_PASSWORD
   ```

4. Load the database:

   ```
   bundle exec rake db:schema:load
   ```

5. Start the server:

   ```
   bundle exec rails server
   ```

6. Visit the site at `http://localhost:3000`

### Note on Patches/Pull Requests ###

- Fork the project.
- Make your feature addition or bug fix on a new branch.
- Add tests for it!
- Commit, do not mess with version, or history.
- Send me a pull request. Bonus points for topic branches.


* * *

#### Footnotes ####

1. [Toronto cyclists fear dooring, but police don't track it](http://www.thestar.com/news/gta/transportation/2013/06/25/toronto_cyclists_fear_dooring_but_police_dont_track_it.html)
2. [Toronto police won't track 'dooring' until they're ordered to do so](http://www.thestar.com/news/gta/2013/08/06/toronto_police_wont_track_dooring_until_theyre_ordered_to_do_so.html)
3. [Police board wants Toronto cops to review ‘dooring’ policy](http://www.thestar.com/news/gta/2013/08/06/police_board_wants_toronto_cops_to_review_dooring_policy.html)

Produced by [@f3ndot](http://www.justinbull.ca) for the [#bikeTO](https://www.twitter.com/search?q=%23BikeTO) community.