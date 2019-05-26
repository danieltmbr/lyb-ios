@testable import Networking
import XCTest

final class NetworkTaskTests: XCTestCase {

    func test_defaultInit() {
        let task = NetworkTask<Json>(request: HttpRequest.test) { (_: Data?, _: Error?) -> Json in
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
			"date": "1992-03-20"
		}
		""".data(using: .utf8)!
        let day = getDay(year: 1992, month: 3, day: 20)

        let task = NetworkTask<Json>(request: HttpRequest.test)
        let decodedJson = try? task.parser(json, nil)

        XCTAssertNotNil(decodedJson)
        XCTAssertEqual(task.request.path, HttpRequest.test.path)
        XCTAssertEqual(decodedJson?.title, "Parse date")
        XCTAssertNotNil(decodedJson?.date.day)
        XCTAssertEqual(decodedJson?.date.day, day)
    }
}

private struct Json: Decodable, Equatable {
    let title: String
    let date: Date

    private enum CodingKeys: String, CodingKey, CustomDateFormat {
        case title
        case date

        var dateFormat: DateFormat? { return .release }
    }

    static let test = Json(title: "test", date: Date())
}

private extension HttpRequest {
    static let test = HttpRequest(path: "test")
}
