import Foundation

public protocol ApiClient {

    typealias WaitingCallback = () -> Void
    typealias Completion<M: Decodable> = (Result<M, Error>) -> Void

    var environment: ApiEnvironment { get }

    func perform<M, T>(task: T, waitingCallback: WaitingCallback?, completion: @escaping Completion<M>)
        where T: Task, M: Decodable, T.Model == M
}

extension ApiClient {

    public func createRequest(for request: Request, config: URLSessionConfiguration? = nil) -> URLRequest {
        // Compose the url
        let url = environment.baseUrl.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url, cachePolicy: request.cachePolicy)

        // Add parameters
        switch request.parameters {
        case .body(let params)?:
            urlRequest.httpBody = params.data
            urlRequest.setValue("\(urlRequest.httpBody?.count ?? 0)", forHTTPHeaderField: "Content-Length")
        case .query(let params)?:
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                assertionFailure("Could not compose components from url: \(url.absoluteString)")
                break
            }
            components.queryItems = params.queryItems
            urlRequest.url = components.url
        default: break
        }

        // Add headers from enviornment, request & config
        environment.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        urlRequest.setValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")

        if let sessionConfigurationHeaders = config?.httpAdditionalHeaders {
            for (name, value) in sessionConfigurationHeaders {
                urlRequest.addValue("\(value)", forHTTPHeaderField: "\(name)")
            }
        }

        // Setup HTTP method
        urlRequest.httpMethod = request.method.rawValue

        return urlRequest
    }
}

private extension Dictionary where Key == String, Value == String {

    var queryItems: [URLQueryItem] {
        return map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

