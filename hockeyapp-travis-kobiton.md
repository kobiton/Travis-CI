# Integrate Kobiton in HockeyApp build pipeline using Travis CI

## Table of content 
 - [Prerequisites](#prerequisites)
 - [1. Deploy mobile application to HockeyApp with Travis CI](#1-deploy-mobile-application-to-hockeyapp-with-travis-ci)

## Prerequisites
 - HockeyApp API token.
 - HockeyApp AppID.
 - Kobiton Account.
 - GitHub repository for ReactNative project.

## Assumptions
 Let's assume you already have a React Native project on GitHub and you have configure Travis CI to continously deploy your app to Hockey App on every push commit.
 >ref link

 In that case, your `.travis.yml` file for the project should look something like this:
 ```yml
#Basic configuration such as language, env,...
script: <YOUR_SCRIPT_TO_DEPLOY_APP_TO_HOCKEYAPP>
 ``` 
ear
## Prepare 


## Integrate Kobiton in the application build pipeline
### 1. Modify Travis CI to allow Kobiton to integrate the flow
In order to integrate Kobiton in the build pipeline, we have to seperate your app deployment and app testing with Kobiton in different stages.
Modify your `.travis,yml` like below:
```yml
jobs:
    include:
    - stage: "Deployment"
    script: <YOUR_SCRIPT_TO_DEPLOY_APP_TO_HOCKEYAPP>
    - stage: "Testing with Kobiton"
```

This guideline will provide you with a sample project written in Node.js which contains functions to fetch your latest app version on Hockey App and run automation test for that version with Kobiton.

Visit [here]() and copy `javascript` folder to your React Native project.

The main script for this sample will be `android-app-test.js`. 
Visit [the previous section]() to know how to run automation test on Kobiton with Travs CI. 

Create a `kobiton-test.sh` file in your project and add these information:
```bash
cd ./javascript
npm run android-app-test
```

Use the `.sh` as your main script for `Testing` stage. Afterward, your `.travis.yml` will look something like this:
```yml
env:
  global:
    - KOBITON_USERNAME=<YOUR_KOBITON_USERNAME>
    - secure: 'qU+dA2z60akrMEUor4wfjAb/9k9k6HI/Q7xBKpibQsu'

jobs:
    include:
    - stage: "Deployment"
    script: <YOUR_SCRIPT_TO_DEPLOY_APP_TO_HOCKEYAPP>
    - stage: "Testing with Kobiton"
    script: "./kobiton-test.sh"
```