import Foundation

public extension URLSessionConfiguration {

    static var lyb: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.waitsForConnectivity = true
        return config
    }
}
