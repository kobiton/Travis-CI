# Call Kobiton REST API to get session information
This part will demonstrate how to get session information with Kobiton rest api. 
>Kobiton supports multiple languages for [API documentation](https://api.kobiton.com/docs). Go to docs for further language support

## Table of contents
  - [Prerequisites](#prerequisites)
  - [1. Authentication](#1-authentication)
  - [2. Get session information through Kobiton REST API](#2-get-session-information-through-kobiton-rest-api)
  - [3. Final result](#3-final-result)  


## Prerequisites
  - Kobiton account.

## 1. Authentication
  Encode your credentials in base64 for HTTP Basic Authenitication. You can use the below command to get the encoded token:  
  `echo -n <your_username>:<your_api_key> | base64`  

  The result should look like this:  
  `dGVzdHVzZXI6MTIzZWQtMTIzZmFjLTkxMzdkY2E=`

## 2. Get session information through Kobiton REST API
* To send an API request: 
  ```
  curl -X GET https://api.kobiton.com/v1/{request_path}
  -H 'Authorization: Basic dGVzdHVzZXI6MTIzZWQtMTIzZmFjLTkxMzdkY2E='
  -H 'Accept: application/json'
  ```

* Get Application Information  
`GET https://api.kobiton.com/v1/apps/{application_ID}`  
You can get your application ID in your desiredCaps.

* Get Session Information  
  `GET https://api.kobiton.com/v1/session/{sessionID}`

  Sample response (if successful):
  ```
  {
    "id" :  3894,
    "userId" :  114,
    "deviceId" :  153,
    "endedAt" :  "2017-04-17T16:02:59.952Z",
    "state" :  "COMPLETE",
    "type" :  "MANUAL",
    "name" :  "Manual testing on Samsung device",
    "description" :  "Test user case #101",
    "createdAt" :  "2017-04-17T16:02:55.182Z",
    "username" :  "Test User",
    "avatarUrl" :  "https://kobiton-us.s3.amazonaws.com/users/114/avatars/1492438501898.jpg",
    "deviceImageUrl" :  "https://s3.amazonaws.com/kobiton/devices/256/samsung-galaxy-s6.png",
    "deviceBooked" :  false,
    "deviceOnline" :  true,
    "isCloud" :  true,
    "executionData" : { ... },
    "log" : { ... },
    "video" : { ... }
  }
  ```
  >For detailed description of each element, visit [here.](https://api.kobiton.com/docs/#sessiondetail)  
  >For more information, visit [Kobiton API Document - Get a session.](https://api.kobiton.com/docs/?javascript--nodejs#get-a-session)  

* Get Session Commands  
`GET https://api.kobiton.com/v1/session/{sessionId}/commands`

  Sample response:
  ```
  {
    "currentPage" :  1,
    "totalPages" :  3,
    "data" : [ ... ]
  }
  ```

  To get a certain page of your commands, add `page` parameter in your query.  
  For example:  
  `GET https://api.kobiton.com/v1/session/{sessionId}/commands?page=2`

  >For detailed description of command data, visit [here.](https://api.kobiton.com/docs/#sessioncommanddata)

>For more details on how to retrieve information about your session, go to https://api.kobiton.com/docs/

## 3. Final result
The test is either a success or failure.  
**Failure Case**  

* Error: "The environment you requested was unavailable." 
    - This means that the device you selected is already booked. Either select a different device or wait a few moments until your device becomes available
  
* Other 
    - Contact Kobiton for support
    - Go to portal.kobiton.com
    - In the navigation bar at the top of the page, click on 'Support'

    ![support](assets/3_kobiton_support.jpg)

    - Fill in the information for your request and submit your ticket

    ![submit-ticket](assets/3_kobiton_submit_ticket.jpg)
-----
Kobiton API document: https://api.kobiton.com/docs



