import XCTest
@testable import Networking

final class ApiClientTests: XCTestCase {

	private var env: MockEnv!
	private var client: Client!

	override func setUp() {
		super.setUp()
		env = MockEnv(name: "Test", baseUrl: URL(string: "https://test.lyb.com")!, headers: ["App-Version":"1"])
		client = Client(environment: env)
	}

	override func tearDown() {
		super.tearDown()
		env = nil
		client = nil
	}

	func test_whenRequestHasQueryParameters_thenHttpBodyIsNil() {

		let request = HttpRequest(
			path: "test",
			headers: ["Test-Field":"Test-Value"],
			parameters: .query(params: ["param":"some"])
		)
		var headers = env.headers!.merging(request.headers!, uniquingKeysWith: { (_, s) -> String in return s} )
		headers["Content-Type"] = request.contentType.rawValue

		let urlRequest = client.createRequest(for: request, config: nil)

		XCTAssertEqual(urlRequest.httpMethod, request.method.rawValue)
		XCTAssertEqual(urlRequest.allHTTPHeaderFields, headers)
		XCTAssertEqual(urlRequest.cachePolicy.rawValue, request.cachePolicy.rawValue)
		XCTAssertEqual("\(urlRequest.url!.scheme!)://\(urlRequest.url!.host!)", env.baseUrl.absoluteString)
		XCTAssertEqual(urlRequest.url?.path, "/\(request.path)")
		XCTAssertEqual(urlRequest.url?.query, request.parameters?.queryString)
		XCTAssertNil(urlRequest.httpBody)
	}

	func test_whenRequestHasBodyParameters_thenQueryParametersAreNil() {

		let body = "Test param".data(using: .utf8)!
		let request = HttpRequest(
			path: "test",
			method: .post,
			headers: ["Test-Field":"Test-Value"],
			parameters: .body(params: body)
		)
		var headers = env.headers!.merging(request.headers!, uniquingKeysWith: { (_, s) -> String in return s} )
		headers["Content-Type"] = request.contentType.rawValue
		headers["Content-Length"] = "\(body.count)"

		let urlRequest = client.createRequest(for: request, config: nil)

		XCTAssertEqual(urlRequest.httpMethod, request.method.rawValue)
		XCTAssertEqual(urlRequest.allHTTPHeaderFields, headers)
		XCTAssertEqual(urlRequest.cachePolicy.rawValue, request.cachePolicy.rawValue)
		XCTAssertEqual("\(urlRequest.url!.scheme!)://\(urlRequest.url!.host!)", env.baseUrl.absoluteString)
		XCTAssertEqual(urlRequest.url?.path, "/\(request.path)")
		XCTAssertEqual(urlRequest.httpBody, body.data)
		XCTAssertNil(urlRequest.url?.query)
	}
}

private final class Client: ApiClient {

	var environment: ApiEnvironment

	init(environment: ApiEnvironment) {
		self.environment = environment
	}

	func perform<M, T>(task: T, waitingCallback: WaitingCallback?, completion: @escaping (Result<M, Error>) -> ())
		where M : Decodable, M == T.Model, T : Task {}
}

private extension RequestParameters {
	var queryString: String? {
		guard case .query(let params) = self else { return nil }
		return params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
	}
}
