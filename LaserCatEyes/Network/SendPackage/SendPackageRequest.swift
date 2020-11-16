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
    let deviceID, appID: String

    enum CodingKeys: String, CodingKey {
        case requestPackage, responsePackage, tags
        case deviceID = "deviceId"
        case appID = "appId"
    }

    init(requestPackage: RequestPackage?, responsePackage: ResponsePackage?, tags: [String], deviceID: String, appID: String) {
        self.requestPackage = requestPackage
        self.responsePackage = responsePackage
        self.tags = tags
        self.deviceID = deviceID
        self.appID = appID
    }
}
