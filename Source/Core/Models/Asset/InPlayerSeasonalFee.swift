//
//  InPlayerSeasonalFee.swift
//  InPlayerSDK
//
//  Created by Oliver Dimitrov on 5/1/20.
//

import Foundation

/// Seasonal Fee model
public struct InPlayerSeasonalFee: Codable {
    
    public let id: Int?
    
    public let accessFeeId: Int?
    
    public let merchantId: Int?
    
    /// True if content is available outside of the season
    public let offSeasonAccess: Bool
    
    /// Current price for the season access
    public let currentPriceAmount: Double?
    
    /// Unix timestamp showing when the rebill for the next season should happen
    public let anchorDate: Double?
    
    public let createdAt: Double?
    public let updatedAt: Double?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case accessFeeId = "access_fee_id"
        case merchantId = "merchant_id"
        case offSeasonAccess = "off_season_access"
        case currentPriceAmount = "current_price_amount"
        case anchorDate = "anchor_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        accessFeeId = try values.decodeIfPresent(Int.self, forKey: .accessFeeId)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        offSeasonAccess = try values.decodeIfPresent(Bool.self, forKey: .offSeasonAccess) ?? false
        currentPriceAmount = try values.decodeIfPresent(Double.self, forKey: .currentPriceAmount)
        anchorDate = try values.decodeIfPresent(Double.self, forKey: .anchorDate)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
    }
    
    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(id, forKey: .id)
        try values.encodeIfPresent(accessFeeId, forKey: .accessFeeId)
        try values.encodeIfPresent(merchantId, forKey: .merchantId)
        try values.encodeIfPresent(offSeasonAccess, forKey: .offSeasonAccess)
        try values.encodeIfPresent(currentPriceAmount, forKey: .currentPriceAmount)
        try values.encodeIfPresent(anchorDate, forKey: .anchorDate)
        try values.encodeIfPresent(createdAt, forKey: .createdAt)
        try values.encodeIfPresent(updatedAt, forKey: .updatedAt)
    }
}
