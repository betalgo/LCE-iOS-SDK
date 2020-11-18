//
//  NetworkManager.swift
//  LaserCatEyes
//
//  Created by Hakkı Yiğit Yener on 15.11.2020.
//

import UIKit

class LaserCatEyes: NSObject {
    static let shared = LaserCatEyes()
    fileprivate var enviroment:String? = "Dev"
    fileprivate var appKeyId = ""
    fileprivate var appName: String? = nil
    fileprivate var isLogging = false
    
    func startLogging(appKeyId: String, enviroment: String? = nil, appName: String? = nil) {
        self.appKeyId = appKeyId
        self.enviroment = enviroment
        self.appName = appName
        self.isLogging = true
        NetworkActivityLogger.shared.startLogging()
        self.sendDeviceInfoToServer()
    }
    
    func stopLogging(){
        NetworkActivityLogger.shared.stopLogging()
        self.isLogging = false
    }

    fileprivate func sendDeviceInfoToServer() {
        guard isLogging == true else {
            return
        }
        
        let device = UserDevice.init(name: machineName(),
                                     userFriendlyName: UIDevice.current.name,
                                     uuid: getDeviceUUID(),
                                     operatingSystem: UIDevice.current.systemName,
                                     osVersion: getOSInfo())
        
        let updateReq = UpdateSubAppRequest.init(operatingSystem: UIDevice.current.systemName,
                                                 name: appName ?? Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String,
                                                 environment: enviroment,
                                                 version: Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String,
                                                 buildNumber: Bundle.main.infoDictionary!["CFBundleVersion"] as! String,
                                                 device: device)
        
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let postData = try! encoder.encode(updateReq)
        print(String(data: postData, encoding: .utf8)!)
        
        let request = self.createRequest(with: "https://lasercateyes-beta.azurewebsites.net/api/App/UpdateSubApp", method: "PUT", bodyData: postData)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    func sendRequestToServer(identifier:String, url:String, headers:[String], body:String, method:String) {
        guard isLogging == true else {
            return
        }
        let requestPackage = RequestPackage(id: identifier,
                                            timeStamp: getTimeStamp(),
                                            url: url,
                                            headers: headers,
                                            body: body,
                                            methodType: method)
        
        let packageRequest = SendPackageRequest(requestPackage: requestPackage,
                                                responsePackage: nil,
                                                tags: [],
                                                deviceID: getDeviceUUID(),
                                                appID: appKeyId)
        
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let postData = try! encoder.encode(packageRequest)
        print(String(data: postData, encoding: .utf8)!)
        
        let request = self.createRequest(with: "https://lasercateyes-beta.azurewebsites.net/api/Data/SendPackage", method: "POST", bodyData: postData)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    func sendResponseToServer(identifier:String, statusCode:Int, headers:[String], body:String) {
        guard isLogging == true else {
            return
        }
        let responsePackage = ResponsePackage(id: identifier,
                                              timeStamp: getTimeStamp(),
                                              statusCode: statusCode,
                                              headers: headers,
                                              body: body)
        
        let packageRequest = SendPackageRequest(requestPackage: nil,
                                                responsePackage: responsePackage,
                                                tags: [],
                                                deviceID: getDeviceUUID(),
                                                appID: appKeyId)
        
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let postData = try! encoder.encode(packageRequest)
        print(String(data: postData, encoding: .utf8)!)
        
        let request = self.createRequest(with: "https://lasercateyes-beta.azurewebsites.net/api/Data/SendPackage", method: "POST", bodyData: postData)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    
    
    fileprivate func createRequest(with url: String, method:String, bodyData:Data?) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("54A247B0-D5EC-4BA0-8E1D-9105DCC54F13", forHTTPHeaderField: "Alg-Client-Id")
        request.addValue("en-US", forHTTPHeaderField: "Alg-Culture")
        request.addValue(getDeviceUUID(), forHTTPHeaderField: "Alg-Device-Id")
        request.addValue(appKeyId, forHTTPHeaderField: "Alg-App-Key-Id")
        
        request.httpMethod = method
        request.httpBody = bodyData
        return request
    }
}

fileprivate extension LaserCatEyes {
    func getOSInfo()->String {
        let os = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
    
    func getDeviceUUID() -> String {
        let key = "deviceUUID"
        if let deviceUUID = UserDefaults.standard.string(forKey: key) {
            return deviceUUID
        }
        let newUUID = UUID().uuidString
        UserDefaults.standard.set(newUUID, forKey: key)
        UserDefaults.standard.synchronize()
        return newUUID
    }
    
    func machineName() -> String {
      var systemInfo = utsname()
      uname(&systemInfo)
      let machineMirror = Mirror(reflecting: systemInfo.machine)
      return machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
      }
    }
    func getTimeStamp() -> String {
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: Date())
    }
}
