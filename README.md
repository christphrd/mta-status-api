# README

Language used: Ruby
Framework used: Rails
Libraries (Gems) used: Nokogiri for scraping & Rufus Scheduler for recurring job

# FEATURES
*Continuously monitors the status of MTA service to see whether a line is delayed or not.
Check config/initializers/scheduler.rb

The Rails server continuously monitors every 5 seconds and prints out changes to the console.

*Exposes an endpoint called /status, which takes the name of a particular line as an argument and returns whether or not the line is currently delayed.
Check config/routes.rb and app/controllers/status_widget_controller.rb

/status/<LINE> will return a JSON detailing whether it is true or false.

```{currentlyDelayed: true}```

# MISCELLANEOUS
In scrape.rb, I tested web scraping with Nokogiri on http://service.mta.info/ServiceStatus/status.html