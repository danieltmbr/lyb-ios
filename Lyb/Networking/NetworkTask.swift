import Foundation

public struct NetworkTask<Model>: Task {

    public typealias Parser = (Data?, Error?) throws -> Model

    public let request: Request
    public let parser: Parser

    public init(request: Request, parser: @escaping Parser) {
        self.request = request
        self.parser = parser
    }
}

extension NetworkTask where Model: Decodable {

    public init(request: Request, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) {
        self.request = request
        parser = { (data, error) in
			if let error = error { throw error }
            guard let data = data else { throw error ?? NetworkTaskError.noData }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            return try decoder.decode(Model.self, from: data)
        }
    }
}

public enum NetworkTaskError: Error {
    case noData
}
