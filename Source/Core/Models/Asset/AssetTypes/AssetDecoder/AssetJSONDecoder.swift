import Foundation

/// Public interface allowing creation of codable object from data
public protocol AssetJSONDecoder {
    
    /**
        Method that returns Generic `Codable` object from `Data`
        - Parameters:
            - data:  Data from which the object need to be constructed
     */
    static func from<T: Codable>(data: Data) throws -> T
}

public extension AssetJSONDecoder {
    static func from<T: Codable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
