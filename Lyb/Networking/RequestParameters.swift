import Foundation

/// Parameters sent as query items
public typealias QueryItems = Dictionary<String, String>

/// Parameters sent in the body
public protocol BodyParameter {
    var data: Data? { get }
}

/// Parameters sent in the request
public enum RequestParameters {
    case body(params: BodyParameter)
    case query(params: QueryItems)
}

extension RequestParameters: Equatable {

	public static func == (lhs: RequestParameters, rhs: RequestParameters) -> Bool {
		switch (lhs, rhs) {
		case (.body(let p1), .body(let p2)): return p1.data == p2.data
		case (.query(let q1), .query(let q2)): return q1 == q2
		default: return false
		}
	}
}

/// Default serialisation for `Encodable` types
extension BodyParameter where Self: Encodable {
	public var data: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            assertionFailure("Could not encode \(self) to data because of: \(error.localizedDescription)")
            return nil
        }
    }
}

extension Data: BodyParameter {
	public var data: Data? { return self }
}
