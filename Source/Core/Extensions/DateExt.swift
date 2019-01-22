import Foundation

extension Date {
    var milisecondsSince1970: Double {
        return (timeIntervalSince1970 * 1000).rounded()
    }
}
