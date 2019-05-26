import Foundation

/// Http method to perform
public enum Method: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
    case patch  = "PATCH"
}

/// Expected response data type
public enum ContentType: String {
    case json = "application/json; charset=utf-8"
    case html = "text/html; charset=utf-8"
    case form = "application/x-www-form-urlencoded; charset=utf-8"
}

public protocol Request {

    /// Relative path of an API endpoint
    var path: String { get }

    /// Http Method to perform
    var method: Method { get }

    /// Expected response data type
    var contentType: ContentType { get }

    /// Http Header keys and values
    var headers: [String: String]? { get }

    /// Parameters to send in the Url
    var parameters: RequestParameters? { get }

    /// Cache policy
    var cachePolicy: URLRequest.CachePolicy { get }
}
