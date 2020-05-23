//
//  InPlayerVoucher.swift
//  InPlayerSDK
//
//  Created by Oliver Dimitrov on 5/1/20.
//

import Foundation

/// Voucher model
public struct InPlayerVoucher: Codable {
    
    /// Brand id
    public let id: Int?
    
    /// Voucher name
    public let name: String?
    
    /// Discount amount in percentage [1..100]
    public let discount: Int?
    
    /// Discount amount in percentage on rebill [1..100]
    public let rebillDiscount: Int?
    
    /// Voucher is valid from this date forward
    public let startDate: Double?
    
    /// Voucher validation ends on this date
    public let endDate: Double?
    
    /// Code provided by the merchant instead of generating it automatically
    public let code: String?
    
    /// Limit the number of times for voucher usage
    public let usageLimit: Int?
    
    /// Number of times voucher was used
    public let usageCounter: Int?
    
    /// Enum: "once" "repeating" "forever". In case this voucher is used for a subscription, you can use a discount period for the recurrent payments
    public let discountPeriod: String?
    
    /// In case the discountPeriod is repeating this field is required, for number of months to repeat the discount
    public let discountDuration: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case discount = "discount"
        case rebillDiscount = "rebill_discount"
        case startDate = "start_date"
        case endDate = "end_date"
        case code = "code"
        case usageLimit = "usage_limit"
        case usageCounter = "usage_counter"
        case discountPeriod = "discount_period"
        case discountDuration = "discount_duration"
    }
    
    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        rebillDiscount = try values.decodeIfPresent(Int.self, forKey: .rebillDiscount)
        startDate = try values.decodeIfPresent(Double.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Double.self, forKey: .endDate)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        usageLimit = try values.decodeIfPresent(Int.self, forKey: .usageLimit)
        usageCounter = try values.decodeIfPresent(Int.self, forKey: .usageCounter)
        discountPeriod = try values.decodeIfPresent(String.self, forKey: .discountPeriod)
        discountDuration = try values.decodeIfPresent(Int.self, forKey: .discountDuration)
    }
    
    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(id, forKey: .id)
        try values.encodeIfPresent(name, forKey: .name)
        try values.encodeIfPresent(discount, forKey: .discount)
        try values.encodeIfPresent(rebillDiscount, forKey: .rebillDiscount)
        try values.encodeIfPresent(startDate, forKey: .startDate)
        try values.encodeIfPresent(endDate, forKey: .endDate)
        try values.encodeIfPresent(code, forKey: .code)
        try values.encodeIfPresent(usageLimit, forKey: .usageLimit)
        try values.encodeIfPresent(usageCounter, forKey: .usageCounter)
        try values.encodeIfPresent(discountPeriod, forKey: .discountPeriod)
        try values.encodeIfPresent(discountDuration, forKey: .discountDuration)
    }
}
