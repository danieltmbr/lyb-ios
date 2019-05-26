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

    public init(request: Request, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .customFormatted) {
        self.request = request
        parser = { (data, error) in
			if let error = error { throw NetworkingError(error: error, type: .response) }
            guard let data = data else { throw NetworkingError(error: NetworkTaskError.noData, type: .parse) }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy

			do {
            	return try decoder.decode(Model.self, from: data)
			} catch {
				throw NetworkingError(error: NetworkTaskError.decode(error), type: .parse)
			}
        }
    }
}

public enum NetworkTaskError: Error {
    case noData
	case decode(Error)
}
