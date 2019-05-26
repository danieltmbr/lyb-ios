@testable import Networking
import XCTest

final class HttpRequestTests: XCTestCase {

    func test_initWithDefaultParameters() {

        // Whenever this test fails because default init params were updated
        // Please make sure you update all the code where default params were used with the previous values

        let path = "www.apple.com"
        let request = HttpRequest(path: path)

        XCTAssertEqual(request.path, path)
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, .json)
        XCTAssertNil(request.headers)
        XCTAssertNil(request.parameters)
        XCTAssertEqual(request.cachePolicy, URLRequest.CachePolicy.returnCacheDataElseLoad)
    }

    func test_initWithCustomParameters() {

        let path = "www.apple.com"
        let method = Networking.Method.post
        let contentType = ContentType.html
        let headers = ["Key": "Value"]
        let params = RequestParameters.body(params: Data())
        let cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData

        let request = HttpRequest(
            path: path,
            method: method,
            contentType: contentType,
            headers: headers,
            parameters: params,
            cachePolicy: cachePolicy
        )

        XCTAssertEqual(request.path, path)
        XCTAssertEqual(request.method, method)
        XCTAssertEqual(request.contentType, contentType)
        XCTAssertEqual(request.headers, headers)
        XCTAssertEqual(request.parameters, params)
        XCTAssertEqual(request.cachePolicy, cachePolicy)
    }
}
