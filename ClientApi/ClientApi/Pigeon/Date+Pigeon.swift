
import Foundation

/*
 Establish a custom date formatter that directly encodes string date into a Date object.
 Example Date: "2020-05-06 23:01:13"
 */
extension Formatter {
    static let customIso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static let customIso8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.customIso8601.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid date: " + string)
        }
        return date
    }
}
