import Foundation

final public class InPlayerMissigTokenError: InPlayerError {
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
        self.init(code: (error as NSError).code,
                  message: (error as NSError).localizedDescription,
                  errorList: [(error as NSError).localizedDescription],
                  error: error)
    }
}
