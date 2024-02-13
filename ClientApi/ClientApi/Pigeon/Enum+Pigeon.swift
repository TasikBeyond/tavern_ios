
import Foundation

public protocol UnknownDefault: Decodable & CaseIterable & RawRepresentable
where RawValue: Decodable, AllCases: BidirectionalCollection { }

// Automatically defaults a failed enum decoding to the last case. (Unknown is the last case in API emuns)
public extension UnknownDefault {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.last!
    }
}
