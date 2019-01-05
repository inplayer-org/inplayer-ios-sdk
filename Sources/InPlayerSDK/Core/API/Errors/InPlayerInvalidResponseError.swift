import Foundation

public class InPlayerInvalidResponseError: InPlayerError {
    public var code: Int
    public var message: String?
    public var errorList: [String]?
    public var originalError: Error

    public required init(code: Int, message: String?, errorList: [String]?, error: Error) {
        self.code = code
        self.message = message
        self.errorList = errorList
        self.originalError = error
    }

    public convenience init(error: Error) {
        self.init(code: 0, message: "Invalid response data", errorList: ["Invalid response data"], error: error)
    }
}

public final class InPlayerInvalidJSONError: InPlayerInvalidResponseError {
    public convenience init(error: Error) {
        let message = "Data cannot be parsed into JSON object"
        self.init(code: 0, message: message, errorList: [message], error: error)
    }

    public required init(code: Int, message: String?, errorList: [String]?, error: Error) {
        super.init(code: code, message: message, errorList: errorList, error: error)
    }
}

