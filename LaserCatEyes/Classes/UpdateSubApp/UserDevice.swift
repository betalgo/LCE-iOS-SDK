// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let device = try? newJSONDecoder().decode(Device.self, from: jsonData)

import Foundation

// MARK: - Device
class UserDevice: Codable {
    let name, userFriendlyName, uuid, operatingSystem: String
    let osVersion: String

    init(name: String, userFriendlyName: String, uuid: String, operatingSystem: String, osVersion: String) {
        self.name = name
        self.userFriendlyName = userFriendlyName
        self.uuid = uuid
        self.operatingSystem = operatingSystem
        self.osVersion = osVersion
    }
}
