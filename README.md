# Travis-HockeyApp-Appium-ReactNative
--------

Guidance on integrating Kobiton service into the mobile app build pipeline: Travis CI, HockeyApp, Appium and ReactNative.  
If you are using:
- Travis CI to build the application.
- HockeyApp for deploy the latest build.
- Appium to run automation test.
- React Native to develop mobile application.

Kobiton is a mobile cloud platform that enables users to perform manual or automated testing on iOS and Android devices. Kobiton is now support Appium v1.8.1.

Travis CI is a hosted, distributed continuous integration service used to build and test software projects hosted at GitHub.

Using Travis CI, we can automatically deploy app and run app automation test on Kobiton deivces everytime a new version is pushed to GitHub.

## Main workflow
### Developers
1. Pushes commit to GitHub repository to start releasing a new build.
### Travis CI 
2. Fetches the latest commit.
3. Archive app package and creates installation file (`.apk`, `.ipa`)
4. Uploads app file to Hockey App
5. Fetches app download URL using Hockey App REST API.
6. Execute automation test on Kobiton.
### Kobiton
7. Runs automation test for the app.
### Travis CI
8. Sets release note `Tested with Kobiton` and test session ID for the latest build on Hockey App.
### Testers
9. Receives the tested build on Hockey App.
10. Gets Kobiton test session to verify the result.

[This guideline](integrate-kobiton-travisci.md) will show you how to automatically execute automation tests on Kobiton devices everytimes a new version of the app is deployed to Hockey App using Travis CI.