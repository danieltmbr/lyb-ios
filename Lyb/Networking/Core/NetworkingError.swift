import Foundation

public enum NetworkingErrorType {
	case response
	case parse
}

public struct NetworkingError: Error {
	public let error: Swift.Error
	public let type: NetworkingErrorType
}
