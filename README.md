
[![Welcome](https://repository-images.githubusercontent.com/305744454/59fff700-30f5-11eb-8a67-d706102bf31c)](https://repository-images.githubusercontent.com/305744454/59fff700-30f5-11eb-8a67-d706102bf31c)
# LaserCatEyes iOS SDK
[![CI Status](https://img.shields.io/travis/HakkiYigitYener/LaserCatEyes.svg?style=flat)](https://travis-ci.org/HakkiYigitYener/LaserCatEyes)
[![Version](https://img.shields.io/cocoapods/v/LaserCatEyes.svg?style=flat)](https://cocoapods.org/pods/LaserCatEyes)
[![License](https://img.shields.io/cocoapods/l/LaserCatEyes.svg?style=flat)](https://cocoapods.org/pods/LaserCatEyes)
[![Platform](https://img.shields.io/cocoapods/p/LaserCatEyes.svg?style=flat)](https://cocoapods.org/pods/LaserCatEyes)

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

Note: For this sdk you must have Alamofire in your project.

#### Hot to get your APP_ID_KEY :
1. Create an account from [Laser-Cat-Eyes web portal]
2. Create an app
3. After the hitting save button you should be able to see your **KEY ID**



<img src="http://www.betalgo.com/img/logo-dark.png" width="10px"> Betalgo

   [Laser-Cat-Eyes web portal]: <https://portal-beta.lasercateyes.com/auth/login>


## Author

Betalgo, mail@betalgo.com

## License

LaserCatEyes is available under the MIT license. See the LICENSE file for more info.
