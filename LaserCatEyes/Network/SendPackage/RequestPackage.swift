// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let requestPackage = try? newJSONDecoder().decode(RequestPackage.self, from: jsonData)

import Foundation

// MARK: - RequestPackage
class RequestPackage: Codable {
    let id, timeStamp, url: String
    let headers: [String]
    let body, methodType: String

    init(id: String, timeStamp: String, url: String, headers: [String], body: String, methodType: String) {
        self.id = id
        self.timeStamp = timeStamp
        self.url = url
        self.headers = headers
        self.body = body
        self.methodType = methodType
    }
}
