// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serviceData = try? newJSONDecoder().decode(ServiceData.self, from: jsonData)

import Foundation

// MARK: - ServiceData
class UpdateSubAppRequest: Codable {
    let operatingSystem, name, environment, version: String
    let buildNumber: String
    let device: UserDevice

    init(operatingSystem: String, name: String, environment: String, version: String, buildNumber: String, device: UserDevice) {
        self.operatingSystem = operatingSystem
        self.name = name
        self.environment = environment
        self.version = version
        self.buildNumber = buildNumber
        self.device = device
    }
}
