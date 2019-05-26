import Foundation

struct DateFormat {
	let format: String

	static let release = DateFormat(format: "yyyy-MM-dd")
}

protocol CustomDateFormat {
	var dateFormat: DateFormat? { get }
}

extension JSONDecoder.DateDecodingStrategy {

	public static var customFormatted: JSONDecoder.DateDecodingStrategy {
		return custom({ (decoder: Decoder) throws -> Date in

			let formatter = DateFormatter()
			if let key = decoder.codingPath.last as? CustomDateFormat, let format = key.dateFormat?.format {
				formatter.dateFormat = format
			}

			let container = try decoder.singleValueContainer()
			let dateString = try container.decode(String.self)

			guard let date = formatter.date(from: dateString) else {
				throw DecodingError.dataCorruptedError(
					in: container,
					debugDescription: "Cannot decode date string \(dateString)"
				)
			}
			
			return date
		})
	}
}
