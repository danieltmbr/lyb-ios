import XCTest
@testable import Networking

final class DefaultDecodableTests: XCTestCase {

    func test_whenArrayMissingFromJson_thenEmptyArrayIsTheDefaultParsedValue() {
		let json = """
		{
			"title": "Missing array"
		}
		""".data(using: .utf8)!

		let decodedJson = try? JSONDecoder().decode(Json.self, from: json)

		XCTAssertNotNil(decodedJson)
		XCTAssertEqual(decodedJson, Json(title: "Missing array", numbers: []))
    }

	func tests_whenArrayIsNotMissingFromJson_thenDefaultValueDoesNotOVerrideCurrentValue() {
		let json = """
		{
			"title": "Missing array",
			"numbers": [1,2,3]
		}
		""".data(using: .utf8)!

		let decodedJson = try? JSONDecoder().decode(Json.self, from: json)

		XCTAssertNotNil(decodedJson)
		XCTAssertEqual(decodedJson, Json(title: "Missing array", numbers: [1,2,3]))
	}
}

private struct Json: Equatable, Decodable {
	let title: String
	let numbers: [Int]
}
