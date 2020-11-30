
[![Welcome](https://repository-images.githubusercontent.com/305744454/59fff700-30f5-11eb-8a67-d706102bf31c)](https://repository-images.githubusercontent.com/305744454/59fff700-30f5-11eb-8a67-d706102bf31c)
# LaserCatEyes iOS SDK - currently in BETA program
[![CI Status](https://img.shields.io/travis/HakkiYigitYener/LaserCatEyes.svg?style=flat)](https://travis-ci.org/HakkiYigitYener/LaserCatEyes)
[![Version](https://img.shields.io/cocoapods/v/LaserCatEyes.svg?style=flat)](https://cocoapods.org/pods/LaserCatEyes)
[![License](https://img.shields.io/cocoapods/l/LaserCatEyes.svg?style=flat)](https://cocoapods.org/pods/LaserCatEyes)
[![Platform](https://img.shields.io/cocoapods/p/LaserCatEyes.svg?style=flat)](https://cocoapods.org/pods/LaserCatEyes)

Laser Cat Eyes is a network monitoring tool that helps mobile app developers diagnose issues between their apps and backend services.

#### Hot to get your APP_KEY :
1. Create an account from [Laser-Cat-Eyes web portal]
2. Create an app
3. After the hitting save button you should be able to see your **APP KEY**

## Installation & Implementation 
1. LaserCatEyes is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
  pod 'LaserCatEyes'
```

2. In ``AppDelegate``'s ``didFinishLaunchingWithOptions`` method add 
```
  LaserCatManager.shared.startLogging(appKeyId: {APP_ID_KEY})
```

3. If you want to stop Logging call 

  ```
  LaserCatManager.shared.stopLogging()
  ```

Note: You can monitor only Alamofire network data with this SDK.

[Laser-Cat-Eyes web portal]: <https://portal-beta.lasercateyes.com/auth/login>


## Author

<img src="http://www.betalgo.com/img/logo-dark.png" width="10px"> Betalgo, mail@betalgo.com
