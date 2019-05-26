@testable import Networking
import XCTest

final class AlbumTests: XCTestCase {

    func test_decodeFromJson() {
        let jsonData = getJsonData(for: "Album")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customFormatted
        let album = try? decoder.decode(Album.self, from: jsonData)

        let albumUrl = URL(string: "https://genius.com/albums/Kanye-west/The-life-of-pablo")!
        let coverUrl = URL(string: "https://images.genius.com/389e5fd1eff885b2e7b62060869945cc.1000x1000x1.jpg")!

        XCTAssertNotNil(album)
        XCTAssertEqual(album?.id, 120604)
        XCTAssertEqual(album?.name, "The Life of Pablo")
        XCTAssertEqual(album?.fullTitle, "The Life of Pablo by Kanye West")
        XCTAssertEqual(album?.artist.name, "Kanye West")
        XCTAssertEqual(album?.url, albumUrl)
        XCTAssertEqual(album?.releaseDate?.day, getDay(year: 2016, month: 2, day: 14))
        XCTAssertEqual(album?.coverArtUrl, coverUrl)
        XCTAssertEqual(album?.featurings.count, 2)
        XCTAssertEqual(album?.writers.count, 1)
        XCTAssertEqual(album?.producers.count, 1)
        XCTAssertEqual(album?.executives.count, 1)
        XCTAssertEqual(album?.labels.count, 1)
    }
}
