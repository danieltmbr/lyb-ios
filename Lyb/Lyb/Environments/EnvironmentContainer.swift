import Foundation

struct EnvironmentContainer: Decodable {
    let environment: Environment

    private enum CodingKeys: String, CodingKey {
        case environment = "Environment"
    }
}

extension Environment {
    static var current: Environment = {
        guard let infoURL = Bundle.main.url(forResource: "Info", withExtension: "plist")
            else { fatalError("No info.plist in main bundle") }
        do {
            let infoData = try Data(contentsOf: infoURL)
            let decoder = PropertyListDecoder()
            let item = try decoder.decode(EnvironmentContainer.self, from: infoData)
            return item.environment
        } catch {
            fatalError("Could not parse Environment: \(error.localizedDescription)")
        }
    }()
}
