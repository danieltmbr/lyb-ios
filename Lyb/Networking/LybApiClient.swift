import Foundation

public final class LybApiClient: NSObject, ApiClient {

    // MARK: - Properties

    public let environment: ApiEnvironment
    
    private let config: URLSessionConfiguration
    private lazy var session: URLSession = {
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    private var waitingCallbacks: [URLRequest: () -> ()] = [:]

    // MARK: - Methods

    public init(environment: ApiEnvironment, config: URLSessionConfiguration = .lyb) {
        self.environment = environment
        self.config = config
        super.init()
    }

    public func perform<M, T>(task: T, waitingCallback: WaitingCallback?, completion: @escaping (Result<M, Error>) -> ())
        where T: Task, M: Decodable, T.Model == M {

            let request = createRequest(for: task.request, config: session.configuration)
            let dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
                self?.waitingCallbacks.removeValue(forKey: request)
                do {
                    let model = try task.parser(data, error)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }

            if let waitingCallback = waitingCallback {
                waitingCallbacks[request] = waitingCallback
            }

            dataTask.resume()
    }
}

// MARK: -

extension LybApiClient: URLSessionTaskDelegate {

    public func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        guard let request = task.originalRequest,
            let callback = waitingCallbacks[request]
            else { return }
        callback()
    }
}
