import Foundation

extension Data {
    func decoded<T: Decodable>(using decoder: JSONDecoder = .init()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
}
