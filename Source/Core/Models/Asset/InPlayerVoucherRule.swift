//
//  InPlayerVoucherRule.swift
//  InPlayerSDK
//
//  Created by Oliver Dimitrov on 5/1/20.
//

import Foundation

/// Voucher Rule model
public struct InPlayerVoucherRule: Codable {
    
    /// Rule ID
    public let id: Int?
    
    /// Rule type
    public let ruleType: String?
    
    /// Value
    public let value: Int?
    
    /// Voucher
    public let voucher: InPlayerVoucher?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ruleType = "rule_type"
        case value = "value"
        case voucher = "voucher"
    }
    
    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        ruleType = try values.decodeIfPresent(String.self, forKey: .ruleType)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        voucher = try values.decodeIfPresent(InPlayerVoucher.self, forKey: .voucher)
    }
    
    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(id, forKey: .id)
        try values.encodeIfPresent(ruleType, forKey: .ruleType)
        try values.encodeIfPresent(value, forKey: .value)
        try values.encodeIfPresent(voucher, forKey: .voucher)
    }
}
