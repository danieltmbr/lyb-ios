import Foundation

public protocol ApiEnvironment {
    var name: String { get }
    var baseUrl: URL { get }
    var headers: [String: String]? { get }
}
