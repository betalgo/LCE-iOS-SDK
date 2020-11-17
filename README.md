# LCE-iOS-SDK

#### To Implement:

1. Download repository.
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

   [Laser-Cat-Eyes web portal]: <https://lasercateyes-portal-beta.azurewebsites.net/auth/login>
