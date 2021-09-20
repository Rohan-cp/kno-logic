# kno-logic
<p align="center">
  <img src="https://imgur.com/P2nDq7b.png" width="180">
</p>

Kno-logic is a cross-platform mobile app that delivers a daily digest of diverse, curated articles for lifelong learners. We hope it can help you break out of your bubble and expose you to new topics and interests (maybe lead you towards a new hobby!). This app was built with [React Native](https://reactnative.dev/) and [Expo](https://expo.io/). We plan on publishing to App Store and Android Store soon.

## Screenshots
<p align="center">
  <img src="https://imgur.com/SxWoD8S.png" width="30%" height="30%" /> <img src="https://imgur.com/lpib2c0.jpg" width="30%" height="30%" /> 
  <img src="https://imgur.com/gnntVKW.png" width="30%" height="30%" />
</p>

## Working Features
* Customised User Interface based on running platform (android or ios)
* Fully functional navigation: profile, saved articles and home
* User Authentication
* Users can save articles to the Saved Articles page
* View articles added on a past day

## Planned Features
* Add push notification when new daily digest arrives
* App Widget
* Generate shareable links
* User Submission (to suggest articles)
* Welcome Page
* Comment on and/or like a an article
* Dark Mode
* In built color averager from image to determine color of article's category

## Developing locally
If you'd like to play around with the code:
You will need Xcode, Android Studio or the Expo Go mobile app to run on your own phone.
Install the latest version of [`Node.js`](https://nodejs.org/en/). Then run
```bash
# install expo client
npm install --global expo-cli

# install dependencies
npm install

# server with hot reload at localhost (press 'r' to reload if changes not reflected) and make sure to turn off production mode on expo page
npm start
```

