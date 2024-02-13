
import Foundation

public struct ApiError {
    public var message: String
    public var code: Int
    public var validationIssues: [String: [String]]?
}
