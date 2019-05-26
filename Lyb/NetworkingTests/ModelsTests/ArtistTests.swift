@testable import Networking
import XCTest

final class ArtistTests: XCTestCase {

    func test_decodeFromJson() {
        let jsonData = getJsonData(for: "Artist")
        let artist = try? JSONDecoder().decode(Artist.self, from: jsonData)

        let artistUrl = URL(string: "https://genius.com/artists/Kanye-west")!
        let imageUrl = URL(string: "https://images.genius.com/a1c9ad953d882a4b336ce3b7576360a1.675x675x1.jpg")!
        let alternateNames = ["Ye", "Yeezy", "Mr. West", "Kanye"]

        XCTAssertNotNil(artist)
        XCTAssertEqual(artist?.id, 72)
        XCTAssertEqual(artist?.name, "Kanye West")
        XCTAssertEqual(artist?.url, artistUrl)
        XCTAssertEqual(artist?.imageUrl, imageUrl)
        XCTAssertEqual(artist?.alternateNames, alternateNames)
        XCTAssertEqual(artist?.facebookName, "")
        XCTAssertEqual(artist?.instagramName, "")
        XCTAssertEqual(artist?.twitterName, "kanyewest")
    }
}
