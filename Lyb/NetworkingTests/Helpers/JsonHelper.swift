import Foundation

func getJsonData(for name: String) -> Data {
    guard let jsonFileUrl = Bundle(for: TestBundle.self).url(forResource: name, withExtension: "json"),
        let jsonData = try? Data(contentsOf: jsonFileUrl)
        else { fatalError("\(name).json not found or in wrong format") }
    return jsonData
}

private final class TestBundle {}
