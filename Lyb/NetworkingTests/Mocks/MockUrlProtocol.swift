//
//  MockUrlProtocol.swift
//  NetworkingTests
//
//  Created by Daniel Tombor on 2019. 05. 26..
//  Copyright © 2019. Daniel Tombor. All rights reserved.
//

import Foundation
import XCTest

final class MockUrlProtocol: URLProtocol {

	static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

	override class func canInit(with request: URLRequest) -> Bool {
		return true
	}
	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return request
	}

	override func startLoading() {
		guard let handler = MockUrlProtocol.requestHandler else {
			XCTFail("Received unexpected request with no handler set")
			return
		}

		do {
			let (response, data) = try handler(request)
			client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			client?.urlProtocol(self, didLoad: data)
			client?.urlProtocolDidFinishLoading(self)
		} catch {
			client?.urlProtocol(self, didFailWithError: error)
		}
	}

	override func stopLoading() {
		client?.urlProtocolDidFinishLoading(self)
	}
}
