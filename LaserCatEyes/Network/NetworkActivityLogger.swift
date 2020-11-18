//
//  NetworkActivityLogger.swift
//  AlamofireNetworkActivityLogger
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Konstantin Kabanov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Alamofire
import Foundation

/// `NetworkActivityLogger` logs requests and responses made by Alamofire.SessionManager, with an adjustable level of detail.
public class NetworkActivityLogger {
    // MARK: - Properties
    
    /// The shared network activity logger for the system.
    public static let shared = NetworkActivityLogger()
    
    /// Omit requests which match the specified predicate, if provided.
    public var filterPredicate: NSPredicate?
    
    private let queue = DispatchQueue(label: "\(NetworkActivityLogger.self) Queue")
    
    private var uuidList : [Int:String] = [:]
    
    // MARK: - Internal - Initialization
    
    init() {
    }
    
    deinit {
        stopLogging()
    }
    
    // MARK: - Logging
    
    /// Start logging requests and responses.
    public func startLogging() {
        stopLogging()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(NetworkActivityLogger.requestDidStart(notification:)),
            name: Request.didResumeNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(NetworkActivityLogger.requestDidFinish(notification:)),
            name: Request.didFinishNotification,
            object: nil
        )
    }
    
    /// Stop logging requests and responses.
    public func stopLogging() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private - Notifications
    
    @objc private func requestDidStart(notification: Notification) {
        queue.async {
            guard let dataRequest = notification.request as? DataRequest,
                let task = dataRequest.task,
                let request = task.originalRequest,
                let httpMethod = request.httpMethod,
                let requestURL = request.url
                else {
                    return
            }
            
            if let filterPredicate = self.filterPredicate, filterPredicate.evaluate(with: request) {
                return
            }
            
            let identifier = UUID().uuidString
            self.uuidList[task.taskIdentifier] = identifier
            var headers = [String]()
            if let httpHeadersFields = request.allHTTPHeaderFields {
                headers = self.getHeadaerList(headers: httpHeadersFields)
            }
            var body = ""
            if let httpBody = request.httpBody, let httpBodyString = String(data: httpBody, encoding: .utf8) {
                body = httpBodyString
            }
            
            LaserCatManager.shared.sendRequestToServer(identifier: identifier,
                                                       url: requestURL.absoluteString,
                                                       headers: headers,
                                                       body: body,
                                                       method: httpMethod)
            
            self.logDivider()
            
            print("\(httpMethod) '\(requestURL.absoluteString)':")
            
            if let httpHeadersFields = request.allHTTPHeaderFields {
                self.logHeaders(headers: httpHeadersFields)
            }
            
            if let httpBody = request.httpBody, let httpBodyString = String(data: httpBody, encoding: .utf8) {
                print(httpBodyString)
            }
        }
    }
    
    @objc private func requestDidFinish(notification: Notification) {
        queue.async {
            guard let dataRequest = notification.request as? DataRequest,
                let task = dataRequest.task,
                let metrics = dataRequest.metrics,
                let request = task.originalRequest,
                let httpMethod = request.httpMethod,
                let requestURL = request.url
                else {
                    return
            }
            
            if let filterPredicate = self.filterPredicate, filterPredicate.evaluate(with: request) {
                return
            }
            
            let elapsedTime = metrics.taskInterval.duration
            
            if let error = task.error {
                self.logDivider()
                
                print("[Error] \(httpMethod) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
                print(error)
            } else {
                guard let response = task.response as? HTTPURLResponse else {
                    return
                }
                
                
                self.logDivider()
                
                print("\(String(response.statusCode)) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
                
                self.logHeaders(headers: response.allHeaderFields)
                
                guard let data = dataRequest.data else {
                    LaserCatManager.shared.sendResponseToServer(identifier: self.uuidList[task.taskIdentifier] ?? "",
                                                                statusCode: response.statusCode,
                                                                headers: self.getHeadaerList(headers: response.allHeaderFields),
                                                                body: "")
                    return
                }

                var body = ""
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    
                    if let prettyString = String(data: prettyData, encoding: .utf8) {
                        body = prettyString
                        print(prettyString)
                    }
                } catch {
                    if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                        body = string as String
                        print(string)
                    }
                }
                LaserCatManager.shared.sendResponseToServer(identifier: self.uuidList[task.taskIdentifier] ?? "",
                                                            statusCode: response.statusCode,
                                                            headers: self.getHeadaerList(headers: response.allHeaderFields),
                                                            body: body)
            }
        }
        
    }
}

private extension NetworkActivityLogger {
    func logDivider() {
        print("---------------------")
    }
    
    func logHeaders(headers: [AnyHashable : Any]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key) : \(value)")
        }
        print("]")
    }
    func getHeadaerList(headers: [AnyHashable : Any]) -> [String] {
        var headerList = [String]()
        for (key, value) in headers {
            headerList.append("\(key):\(value)")
        }
        return headerList
    }
}
