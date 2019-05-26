import Foundation

public struct HttpRequest: Request {

    public let path: String
    public let method: Method
    public let contentType: ContentType
    public let headers: [String: String]?
    public let parameters: RequestParameters?
    public let cachePolicy: URLRequest.CachePolicy

    public init(
        path: String,
        method: Method = .get,
        contentType: ContentType = .json,
        headers: [String: String]? = nil,
        parameters: RequestParameters? = nil,
        cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
        ) {
        self.path = path
        self.method = method
        self.contentType = contentType
        self.headers = headers
        self.parameters = parameters
        self.cachePolicy = cachePolicy
    }
}
