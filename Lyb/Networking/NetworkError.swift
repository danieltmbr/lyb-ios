import Foundation

public enum NetworkErrorType {
	case request
	case parse
}

public struct NetworkError: Error {
	public let error: Swift.Error
	public let type: NetworkErrorType
}
