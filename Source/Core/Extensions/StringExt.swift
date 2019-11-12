import Foundation

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data as Data, encoding: .utf8)
    }
    
    func toBase64() -> String? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    func toJsonData() throws -> Data? {
        guard let contentData = data(using: .utf8) else { return nil }
        do {
            let json = try JSONSerialization.jsonObject(with: contentData, options: .allowFragments)
            let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            return data
        }
        catch {
            return nil
        }
    }
}
