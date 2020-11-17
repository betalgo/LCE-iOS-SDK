# LCE-iOS-SDK
<img src="http://lasercateyes-portal-beta.azurewebsites.net/media/logos/logo-letter-2.png" width="50%">

#### To Implement:

1. Download lastest release.
2. Copy Network folder to your project.
3. In ``AppDelegate``'s ``didFinishLaunchingWithOptions`` method add 
```
LaserCatManager.shared.startLogging(appKeyId: {APP_ID_KEY})
```
##### To Stop Logging:
1. Call 'LaserCatManager.shared.stopLogging()' method.

Note: You must have Alamofire in your project.

#### Hot to get your APP_ID_KEY :
1. Create an account from [Laser-Cat-Eyes web portal]
2. Create an app
3. After the hitting save button you should be able to see your **KEY ID**



<img src="http://www.betalgo.com/img/logo-dark.png" width="10px"> Betalgo

   [Laser-Cat-Eyes web portal]: <https://lasercateyes-portal-beta.azurewebsites.net/auth/login>
