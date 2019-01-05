import Foundation

public class InPlayerHttpError: InPlayerError {
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
}
