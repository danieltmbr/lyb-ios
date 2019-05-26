import Foundation

public protocol DefaultValue {
    static var defaultValue: Self { get }
}

public protocol DefaultDecodable: Decodable & DefaultValue {}
public typealias DefaultCodable = DefaultDecodable & Encodable

extension KeyedDecodingContainer {

    public func decode<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T
        where T: Decodable & DefaultValue {
            var result: T?
            do {
                result = try decodeIfPresent(T.self, forKey: key)
            } catch {
                assertionFailure("Could not decode value. \(error.localizedDescription)")
            }
            return result ?? T.defaultValue
    }
}

extension Array: DefaultValue {
    public static var defaultValue: [Element] {
        return []
    }
}
