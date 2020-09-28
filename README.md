# README

## What is it?

lets you search through clients belonging to a salon, and create vouchers for any given client found

## Getting started

This is a fairly standard rails app. I have included a docker-compose and Dockerfile but this isn't necessary to get started.

Setup the database:

`bundle exec rake db:setup`

Run the tests:

`bundle exec rspec`

### ENV variables required

```
RUNNING_DOCKER=true
BUNDLE_PATH=/cache
PHOREST_BUSINESS_ID=xxx
PHOREST_BRANCH_ID=xxx
PHOREST_USERNAME=xxx
PHOREST_PASSWORD=xxx
REDIS_URL=redis://redis:6379/
```

As always the values depend on your setup / credentials

### Quick summary

We have a rails app that integrates with the Phorest api back end. We only persist vouchers in our own database just to handle any delays when creating them via the API. The app is designed to work on a machine within a given branch location, which is why we have skipped things like a login screen, and the branch id is actually an ENV variable as opposed to handling multiple companies.

## Initial thoughts

When picturing this application working in a salon, there are a few things that come to mind:

- The App should work while having no access to the internet (or the phorest service is down)
- The App doesn't necessarily have to be a web app
-  (Nice to Have) The staff may prefer to access the app from multiple devices
- (Nice to Have) Search can get detailed and complex very quickly. Ideally I would have used elasticsearch as I've had good experience with that, but given the time constraints I will limit this to a basic query.
- (Nice to Have) Maybe be nice to identify which staff member creates the voucher using some sort of logging in mechanism. This wasn't in the requirements so going to leave it out, but maybe a personal pin would be the fastest way for a staff member to get into the system, or using their own device.
- Need a focus on speed here. Given the application is in the salon, the staff would like to focus on the client as much as possible as opposed to a screen. So reducing the amount of input required, and optimizing the search is an important aspect of the user experience. One test I would be interested in doing, is adding pictures to the client record, as maybe identifying a client by their appearance is quicker than by their name.

## The initial tech plan?

This will mostly be driven by what I'm familiar with technology wise, and what would be the most productive in a few hours. I'll be using sidekiq for async communication with the service, with recommendations for sidekiq-pro later for things like scheduled tasks and batch operations. Rails for the back end of course, and I'm going to avoid a css framework for now in the interest of speed, but if this was a real application I'd go with either bootstrap/materialize-sass, or single page application with a framework like vuetify. I'm also going to store as much of the data as I need locally, while allowing the user to add more information about the customer.

Looks like the documentation is written using swagger. Based on that I found a gem that lets me write tests and generate the documentation at the same time so I'm going to try that out.

## Code Explanation
### Patterns used
 - Provide a service to talk to the phorest API providing a suitable abstraction
 - Avoid the use of activerecord callbacks (SyncVoucher)
 - Always use strong params
 - Try to handle a service being down as much as possible (Vouchers)
 - Always store amounts of money in cents (or the lowest unit)
 - Avoid using the client to pass around data (automated_params)
 - Use ENV.fetch to raise an explicit exception so the developer realizes it's missing

### What I would change

- I decided not to download the client list locally. Given the way the API works, and my own time constraints, managing the synced data would be too time consuming. My plan was to have a single field to search all three attributes, firstName, lastName and email. After reviewing the test criteria, it does say "A ruby on rails application backed by our API which allows you to search for a client". I'm going to assume here that "backed by the API" suggest no local data storage.
- I'd remove the creating_branch_id from the Voucher model. Seen as this will always be the same on the machine, we can just keep that context in the `PhorestGatewayService`
- UI needs a lot of love.
- Didn't get time to mess around with adding swagger, but the rails app doesn't have an SPA, and isn't really an API in the strict sense so the documentation would have been purely for demonstrative purposes. May add it to my own projects though.
- Use one field to search all three attributes on the client (firstName, lastName and email)
