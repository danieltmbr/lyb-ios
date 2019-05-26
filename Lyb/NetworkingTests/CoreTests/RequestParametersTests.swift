@testable import Networking
import XCTest

final class RequestParametersTests: XCTestCase {

    func test_whenBodyParameterIsEncodable_thenDataIsEncodedAsJsonByDefault() {
        let param = Parameter(number: 0)

        let defaultEncodedData = param.data
        let jsonEncodedData = try? JSONEncoder().encode(param)

        XCTAssertEqual(defaultEncodedData, jsonEncodedData)
    }
}

private struct Parameter: BodyParameter, Encodable {
    let number: Int
}
