import Foundation

/**
 Invalid Response Error
 */
public struct InPlayerInvalidResponseError: InPlayerError {
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

    init(error: Error) {
        self.init(code: 0, message: "Invalid response data", errorList: ["Invalid response data"], error: error)
    }
}

/**
 Invalid JSON Error
 */
public struct INPInvalidJSONError: InPlayerError {
    public var code: Int
    public var message: String?
    public var errorList: [String]?
    public var originalError: Error


    init(error: Error) {
        let message = "Data cannot be parsed into JSON object"
        self.init(code: 0, message: message, errorList: [message], error: error)
    }

    public init(code: Int, message: String?, errorList: [String]?, error: Error) {
        self.code = code
        self.message = message
        self.errorList = errorList
        self.originalError = error
    }
}

