# Call Kobiton REST API to get session information

## 3.1 Authentication
To make a request:
- Encode your credential in base64 for HTTP Basic Authenitication. You can run this command below to get the encoded token
`echo -n <your_username>:<your_api_key>`

If your are using NodeJs, you can use `btoa` module to encode your credential.
~~~
const btoa = require('btoa')
var basicAuth = btoa({your_username}:{your_api_key})
~~~

- Set the headers for the request
~~~
var header = {
  'Authorization': 'Basic dGhhbmd2bzo1MDFhYzFhOS1mM2ZiLTRlMDQtOWZhO='
  'Accept': 'application/json'
}
~~~

## 3.2 Send your API request
- In NodeJs, we can use `request` module to send your API request
~~~
const request = require('request');

const headers = {
  'Authorization': 'Basic dGVzdHVzZXI6MTIzZWQtMTIzZmFjLTkxMzdkY2E=',
  'Accept':'application/json'

};

request({
  url: 'https://api.kobiton.com/v1/{request_path}',
  json: true,
  method: 'GET',

  headers: headers
}, function (err, response, body) {
  //Handle your response here
});
~~~

- You can also use curl commands:
~~~
curl -X GET https://api.kobiton.com/v1/{request_path}
-H 'Authorization: Basic dGVzdHVzZXI6MTIzZWQtMTIzZmFjLTkxMzdkY2E='
-H 'Accept: application/json'
~~~

### 3.2.1 Get Application Info
`GET /apps/{application_id}`
You can get your application id in your desiredCaps.

### 3.2.2 Get Session Info
`GET /session/{sessionId}`

Response elements:
- `state`: Test final result
- `deviceBooked`: Check if the device is booked
- `log`: Test log (text + video)
* Log url and video url might take a while to be uploaded to Kobtion Portal. Therefore, you will have to wait before getting your session information.

For more information, check [Kobiton API Document](https://api.kobiton.com/docs/?javascript--nodejs#get-a-session)  

### 3.2.2 Get Session Commands
`GET /session/{sessionId}/commands`

To get a certain page of your commands, add `page` parameter in your query
For example:
`GET /session/{sessionId}/commands?page=2`

## 3.3 Final result
The test is either a success or failure.  
**Failure Case**  
* **Device if already booked, please select another device.**  
This means your device is already in-used. You may either select another device or turn off the booked one.  
* **Other**  
Contact Kobiton for more support

-----
Kobiton API document: [https://api.kobiton.com/docs](https://api.kobiton.com/docs)



