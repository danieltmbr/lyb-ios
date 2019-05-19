import Foundation

public protocol Task {
    associatedtype Model
    typealias Parser = (Data?, Error?) throws -> Model

    var request: Request { get }
    var parser: Parser { get }
}
