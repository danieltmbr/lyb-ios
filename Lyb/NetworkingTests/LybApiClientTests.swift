//
//  LybApiClientTests.swift
//  NetworkingTests
//
//  Created by Daniel Tombor on 2019. 05. 26..
//  Copyright © 2019. Daniel Tombor. All rights reserved.
//

import XCTest
@testable import Networking

final class LybApiClientTests: XCTestCase {

	private var env: MockEnv!
	private var client: LybApiClient!

	override func setUp() {
		super.setUp()
		env = MockEnv(name: "Test", baseUrl: URL(string: "https://test.lyb.com")!, headers: ["App-Version":"1"])

		let config = URLSessionConfiguration.ephemeral
		config.protocolClasses = [MockUrlProtocol.self]

		client = LybApiClient(environment: env, config: config)
	}

	override func tearDown() {
		super.tearDown()
		env = nil
		client = nil
	}

	func test_performRequest() {
		let mockJSONData = "{\"name\":\"Kanye West\"}".data(using: .utf8)!
		MockUrlProtocol.requestHandler = { request in
			XCTAssertEqual(request.url?.path.contains("name"), true)
			return (HTTPURLResponse(), mockJSONData)
		}
		let task = MockTask<MockModel>(request: HttpRequest(path: "name"))

		var response: MockModel?

		let expectation = XCTestExpectation(description: "response")
		client.perform(task: task, waitingCallback: nil) { result in
			response = try? result.get()
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1)

		XCTAssertEqual(response, MockModel(name: "Kanye West"))
	}
}

private struct MockModel: Decodable, Equatable {
	let name: String
}

private struct MockTask<M: Decodable>: Task {
	typealias Model = M
	let request: Request
	let parser: (Data?, Error?) throws -> M = { (data, error) throws -> M in
		guard let data = data else { throw NetworkTaskError.noData }
		return try JSONDecoder().decode(M.self, from: data)
	}
}
