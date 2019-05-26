@testable import Networking
import XCTest

final class LabelTests: XCTestCase {

    func test_decodeFromJson() {
        let jsonData = getJsonData(for: "Label")
        let label = try? JSONDecoder().decode(Label.self, from: jsonData)

        let labelUrl = URL(string: "https://genius.com/artists/Def-jam-recordings")!
        let imageUrl = URL(string: "https://images.genius.com/f3374b6a83bc9d6248a7464cef582482.512x512x1.png")!

        XCTAssertNotNil(label)
        XCTAssertEqual(label?.id, 79113)
        XCTAssertEqual(label?.name, "Def Jam Recordings")
        XCTAssertEqual(label?.url, labelUrl)
        XCTAssertEqual(label?.imageUrl, imageUrl)
    }
}
