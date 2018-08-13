# Authentication

The DH API uses JWT [(JSON Web Tokens)](https://tools.ietf.org/html/rfc7519) to identify and authenticate its users. This token must be provided inside an `Authorization` header, with the form `Bearer: <token>`.

## How to generate your private token

To generate your own token, perform the following steps:


1. Navigate to [here](http://api.apihighways.org/auth/login?callbackUrl=https://www.apihighways.org/token&token=true). If you aren't logged in yet, the application will redirect you to the login page. You will see the login page:

![Control Tower login page](images/authentication/login.png)

You can login with your DH credentials (email and password) or with other auth providers (a Google, Facebook, or Twitter account). If you can't remember your password (don't worry! it happens to everyone!) you can reset your password clicking on 'Recover password'.

2. After logging in you will be redirected to the generate token page where you can generate your authentication token to access the API:
![Generate Token](images/authentication/generatetoken.png)

3. Copy your token clicking the Copy button. Remember to add the header `Authorization: Bearer: <yourToken>` to any API call to authenticate yourself.