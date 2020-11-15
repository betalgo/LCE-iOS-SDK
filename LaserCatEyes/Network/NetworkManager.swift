//
//  NetworkManager.swift
//  LaserCatEyes
//
//  Created by Hakkı Yiğit Yener on 15.11.2020.
//

import UIKit

class LaserCatManager: NSObject {
    static let shared = LaserCatManager()
    
    func senToServer() {
        let device = UserDevice.init(name: "DeviceName",
                                     userFriendlyName: "UserFriendlyDeviceName",
                                     uuid: "UUID",
                                     operatingSystem: "iOS",
                                     osVersion: "OSVersion")
        
        let updateReq = UpdateSubAppRequest.init(operatingSystem: "iOS",
                                                 name: "AppName",
                                                 environment: "Enviroment",
                                                 version: "Version",
                                                 buildNumber: "BuildNumber",
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
    
    
    
    func createRequest(with url: String, method:String, bodyData:Data?) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("54A247B0-D5EC-4BA0-8E1D-9105DCC54F13", forHTTPHeaderField: "Alg-Client-Id")
        request.addValue("9cd24f12-b448-4d9b-a688-08d7d5adb68c", forHTTPHeaderField: "Alg-Node-Id")
        request.addValue("5fd5d460-f2e2-4a63-94ae-e1af5ff329a3", forHTTPHeaderField: "Alg-App-Id")
        request.addValue("en-US", forHTTPHeaderField: "Alg-Culture")
        request.addValue("3fa85f64-5717-4562-b3fc-2c963f66afa6", forHTTPHeaderField: "Alg-Device-Id")
        request.addValue("4132542f-4f2e-4466-81cb-b593e40cbed6", forHTTPHeaderField: "Alg-App-Key-Id")
        request.httpMethod = method
        request.httpBody = bodyData
        return request
    }
}
