// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let responsePackage = try? newJSONDecoder().decode(ResponsePackage.self, from: jsonData)

import Foundation

// MARK: - ResponsePackage
class ResponsePackage: Codable {
    let id, timeStamp: String
    let statusCode: Int
    let headers: [String]
    let body: String

    init(id: String, timeStamp: String, statusCode: Int, headers: [String], body: String) {
        self.id = id
        self.timeStamp = timeStamp
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
    }
}
