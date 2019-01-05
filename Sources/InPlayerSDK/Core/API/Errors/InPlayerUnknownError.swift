import Foundation

public final class InPlayerUnknownError: InPlayerError {
    public var code: Int
    public var message: String?
    public var errorList: [String]?
    public var originalError: Error

    public init(code: Int, message: String?, errorList: [String]?, error: Error) {
        self.code = code
        self.message = message
        self.errorList = errorList
        self.originalError = error
    }

    public convenience init(error: Error) {
        self.init(code: 0, message: "Unknown error occured", errorList: ["Unknown error occured"], error: error)
    }
}
