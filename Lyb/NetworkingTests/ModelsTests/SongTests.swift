import XCTest
@testable import Networking

final class SongTests: XCTestCase {

	func test_decodeFromJson() {
		let jsonData = getJsonData(for: "Song")

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .customFormatted
		let song = try? decoder.decode(Song.self, from: jsonData)

		let songUrl = URL(string: "https://genius.com/Kanye-west-saint-pablo-lyrics")!
		let songArtUrl = URL(string: "https://images.genius.com/389e5fd1eff885b2e7b62060869945cc.1000x1000x1.jpg")!
		let lyrics = "Yeah, you're lookin' at the church in the night sky Wonderin' whether God's gonna say hi"

		XCTAssertNotNil(song)
		XCTAssertEqual(song?.id, 2428259)
		XCTAssertEqual(song?.title, "Saint Pablo")
		XCTAssertEqual(song?.fullTitle, "Saint Pablo by Kanye West (Ft. Sampha)")
		XCTAssertEqual(song?.titleWithFeatured,"Saint Pablo (Ft. Sampha)")
		XCTAssertEqual(song?.artist.id, 72)
		XCTAssertEqual(song?.path, "/Kanye-west-saint-pablo-lyrics")
		XCTAssertEqual(song?.url, songUrl)
		XCTAssertEqual(song?.lyricsState, .complete)
		XCTAssertEqual(song?.lyrics, lyrics)
		XCTAssertEqual(song?.releaseDate?.day, getDay(year: 2016, month: 6, day: 15))
		XCTAssertEqual(song?.album?.id, 120604)
		XCTAssertEqual(song?.featuredArtists.count, 1)
		XCTAssertEqual(song?.producerArtists.count, 1)
		XCTAssertEqual(song?.writerArtists.count, 1)
		XCTAssertEqual(song?.songArtImageUrl, songArtUrl)
		XCTAssertNil(song?.headerImageThumbnailUrl)
	}
}
