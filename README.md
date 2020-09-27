# README

## Initial thoughts

When picturing this application working in a salon, there are a few things that come to mind:

- The App should work while having no access to the internet (or the phorest service is down)
- The App doesn't necessarily have to be a web app
-  (Nice to Have) The staff may prefer to access the app from multiple devices
- (Nice to Have) Search can get detailed and complex very quickly. Ideally I would have used elasticsearch as I've had good experience with that, but given the time constraints I will limit this to a basic query.
- (Nice to Have) Maybe be nice to identify which staff number creates the voucher using some sort of logging in mechanism. This wasn't in the requirements so going to leave it out, but maybe a personal pin would be the fastest way for a staff member to get into the system, or using their own device.
- Need a focus on speed here. Given the application is in the salon, the staff would like to focus on the client as much as possible as opposed to a screen. So reducing the amount of input required, and optimizing the search is an important aspect of the user experience. One test I would be interested in doing, is adding pictures to the client record, as maybe identifying a client by their appearance is quicker than by their name.

## What tech to use?

This will mostly be driven by what I'm familiar with technology wise, and what would be the most product in a few hours. I'll be using sidekiq for async communication with the service, with recommendations for sidekiq-pro later for things like scheduled tasks and batch operations. Rails for the back end of course, and I'm going to avoid a css framework for now in the interest of speed, but if this was a real application I'd go with either bootstrap/materialize-sass, or single page application with a framework like vuetify. I'm also going to store as much of the data as I need locally, while allowing the user to add more information about the customer.

Looks like the documentation is written using swagger. Based on that I found a gem that lets me write tests and generate the documentation at the same time so I'm going to try that out.

## Code Explanation
TODO

## What I would change
TODO