// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serviceData = try? newJSONDecoder().decode(ServiceData.self, from: jsonData)

import Foundation

// MARK: - ServiceData
class UpdateSubAppResponse: Codable {
    let deviceId: String

    enum CodingKeys: String, CodingKey {
        case deviceId
    }

    init(deviceId: String) {
        self.deviceId = deviceId
    }
}
