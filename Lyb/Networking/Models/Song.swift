import Foundation

public enum LyricsState: String, RawRepresentable, DefaultDecodable {
    case complete
    case unreleased
    case other

    public static var defaultValue: LyricsState = .other
}

public struct Song: Decodable {

    public typealias Id = Int64

    public let id: Id
    public let title: String
    public let fullTitle: String
    public let titleWithFeatured: String
    public let artist: Artist
    public let path: String
    public let url: URL
    public let lyricsState: LyricsState

    public let lyrics: String?
    public let releaseDate: Date?
    public let album: Album?
    public let featuredArtists: [Artist]
    public let producerArtists: [Artist]
    public let writerArtists: [Artist]
    public let songArtImageUrl: URL?
    public let headerImageThumbnailUrl: URL?

    private enum CodingKeys: String, CodingKey, CustomDateFormat {
        case id
        case title
        case fullTitle = "full_title"
        case titleWithFeatured = "title_with_featured"
        case artist = "primary_artist"
        case path
        case url
        case lyricsState = "lyrics_state"
        case lyrics
        case releaseDate = "release_date"
        case album
        case featuredArtists = "featured_artists"
        case producerArtists = "producer_artists"
        case writerArtists = "writer_artists"
        case songArtImageUrl = "song_art_image_url"
        case headerImageThumbnailUrl = "header_image_thumbnail_url"

        var dateFormat: DateFormat? {
            switch self {
            case .releaseDate: return .release
            default: return nil
            }
        }
    }
}
