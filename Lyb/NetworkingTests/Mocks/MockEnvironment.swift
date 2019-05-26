import Networking

struct MockEnv: ApiEnvironment {
    let name: String
    let baseUrl: URL
    let headers: [String: String]?
}
