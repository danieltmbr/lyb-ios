import Foundation

public struct Album: Decodable {

    public typealias Id = Int64

    public let id: Id
    public let name: String
    public let fullTitle: String
    public let artist: Artist
    public let url: URL

    public let releaseDate: Date?
    public let coverArtUrl: URL?

    public let featurings: [Artist]
    public let writers: [Artist]
    public let producers: [Artist]
    public let executives: [Artist]
    public let labels: [Label]

    private enum CodingKeys: String, CodingKey, CustomDateFormat {
        case id
        case name
        case fullTitle = "full_title"
        case url
        case artist
        case releaseDate = "release_date"
        case coverArtUrl = "cover_art_url"
        case featurings
        case writers
        case producers
        case executives = "executive_producers"
        case labels

        var dateFormat: DateFormat? {
            switch self {
            case .releaseDate: return .release
            default: return nil
            }
        }
    }
}
