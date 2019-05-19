import XCTest
@testable import Networking

final class NetworkTaskTests: XCTestCase {

    func test_defaultInit() {
		let task = NetworkTask<Json>(request: HttpRequest.test) { (data: Data?, error: Error?) -> Json in
			return .test
		}
		let decodedJson = try? task.parser(nil, nil)

		XCTAssertNotNil(decodedJson)
		XCTAssertEqual(task.request.path, HttpRequest.test.path)
		XCTAssertEqual(decodedJson, Json.test)
    }

    func test_whenNoParserIsInjected_thenDefaultParserWillParseData() {
		let json = """
		{
			"title": "Parse date",
			"date": "1992-03-20T12:00:00Z"
		}
		""".data(using: .utf8)!
		let day = getDay(of: Calendar.current.date(from: DateComponents(year: 1992, month: 3, day: 20)))

		let task = NetworkTask<Json>(request: HttpRequest.test)
		let decodedJson = try? task.parser(json, nil)

		XCTAssertNotNil(decodedJson)
		XCTAssertEqual(task.request.path, HttpRequest.test.path)
		XCTAssertEqual(decodedJson?.title, "Parse date")
		XCTAssertNotNil(getDay(of: decodedJson?.date))
		XCTAssertEqual(getDay(of: decodedJson?.date), day)
    }

	private func getDay(of date: Date?) -> DateInterval? {
		guard let date = date else { return nil }
		return Calendar.current.dateInterval(of: .day, for: date)
	}

}

private struct Json: Decodable, Equatable {
	let title: String
	let date: Date

	static let test = Json(title: "test", date: Date())
}

private extension HttpRequest {
	static let test = HttpRequest(path: "test")
}
