//
//  Webservice.swift
//  WebserviceExample
//
//  Created by Greyson Wright on 6/20/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import UIKit

enum StatusCode: Int {
	case none = 0
	case _continue = 101
	case switchingProtocols = 102
	case ok = 200
	case created = 201
	case accepted = 202
	case nonAuthoritativeInformation = 203
	case noContent = 204
	case resetContent = 205
	case partialContent = 206
	case multipleChoices = 300
	case movedPermanently = 301
	case found = 302
	case seeOther = 303
	case notModified = 304
	case useProxy = 305
	case unused = 306
	case temporaryRedirect = 307
	case badRequest = 400
	case unauthorized = 401
	case paymentRequired = 402
	case forbidden = 403
	case notFound = 404
	case methodNotAllowed = 405
	case notAcceptable = 406
	case proxyAuthenticationRequired = 407
	case requestTimeout = 408
	case conflict = 409
	case gone = 410
	case lengthRequired = 411
	case preconditionFailed = 412
	case requestEntityTooLarge = 413
	case requestURITooLong = 414
	case unsupportedMediaType = 415
	case requestedRangeNotSatisfiable = 416
	case expectationFailed = 417
	case internalServerError = 500
	case notImplemented = 501
	case badGateway = 502
	case serviceUnavailable = 503
	case gatewayTimeout = 504
	case httpVersionUnsupported = 505
}

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
}

extension URLSession {
	private func buildError(with statusCode: StatusCode) -> Error {
		let error = NSError(domain: "\(statusCode)", code: statusCode.rawValue, userInfo: nil)
		return error
	}
	
	private func buildURLRequest(with urlString: String, httpMethod: HTTPMethod, headers: [String : String]?, requestBody: Data?) -> URLRequest {
		let url = URL(string:urlString)!
		var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
		
		urlRequest.httpMethod = httpMethod.rawValue
		if requestBody != nil {
			urlRequest.httpBody = requestBody!
		}
		urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		if headers != nil {
			for headerPair in headers! {
				urlRequest.setValue(headerPair.value, forHTTPHeaderField: headerPair.key)
			}
		}
		
		return urlRequest
	}
	
	func request(with url: String, httpMethod: HTTPMethod, headers: [String : String]?, requestBody: Data?, response: @escaping (Data?, StatusCode) -> Swift.Void, error: @escaping (Error) -> Swift.Void) {
		let urlRequest = buildURLRequest(with: url, httpMethod: httpMethod, headers: headers, requestBody: requestBody)
		
		let task = dataTask(with: urlRequest) { (data: Data?, urlResponse: URLResponse?, requestError: Error?) in
			guard let httpResponse = urlResponse as? HTTPURLResponse else {
				guard let requestError = requestError else {
					let noStatusCodeError = self.buildError(with: .none)
					error(noStatusCodeError)
					return
				}
				error(requestError)
				return
			}
			
			let statusCode = StatusCode(rawValue: httpResponse.statusCode)!
			if statusCode.rawValue >= 100 && statusCode.rawValue < 300 {
				response(data, statusCode)
			} else {
				let responseError = self.buildError(with: statusCode)
				error(responseError)
			}
		}
		task.resume()
	}
}
