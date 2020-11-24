// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serviceData = try? newJSONDecoder().decode(ServiceData.self, from: jsonData)

import Foundation

// MARK: - ServiceData
class SendPackageRequest: Codable {
    let requestPackage: RequestPackage?
    let responsePackage: ResponsePackage?
    let tags: [String]
    let deviceUUId: String
    let appId: String
    let deviceId: String?

    enum CodingKeys: String, CodingKey {
        case requestPackage, responsePackage, tags, deviceUUId, deviceId, appId
        
    }

    init(requestPackage: RequestPackage?, responsePackage: ResponsePackage?, tags: [String], deviceUUId: String, appId: String, deviceId: String?) {
        self.requestPackage = requestPackage
        self.responsePackage = responsePackage
        self.tags = tags
        self.deviceUUId = deviceUUId
        self.appId = appId
        self.deviceId = deviceId
    }
}
