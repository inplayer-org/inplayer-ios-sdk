//
//  InPlayerExternalPaymentFailed.swift
//  InPlayerSDK
//
//  Created by Kire Jankulovski on 2/22/22.
//

import Foundation

/// External payment failed model
public struct InPlayerExternalPaymentFailed: Codable {
    public var message: String?
    public var explain: String?
    public var code: String?

    private enum CodingKeys: String, CodingKey {
        case message
        case explain
        case code
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        explain = try values.decodeIfPresent(String.self, forKey: .explain)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }
}
