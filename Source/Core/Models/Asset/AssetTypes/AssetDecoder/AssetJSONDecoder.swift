import Foundation

public protocol AssetJSONDecoder {
    
    static func from<T: Codable>(data: Data) throws -> T
}

public extension AssetJSONDecoder {
    static func from<T: Codable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
