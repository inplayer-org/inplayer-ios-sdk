import Foundation

/**
 Unknown Error
 */
public struct InPlayerUnknownError: InPlayerError {
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
        let message = "Unknown error occured"
        self.init(code: 0, message: message, errorList: [message], error: error)
    }
}
