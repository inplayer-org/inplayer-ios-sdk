import Foundation

public extension Date {
    public var milisecondsSince1970: Double {
        return (timeIntervalSince1970 * 1000).rounded()
    }
}
