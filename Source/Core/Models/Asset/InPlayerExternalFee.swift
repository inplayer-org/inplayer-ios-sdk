//
//  InPlayerExternalFee.swift
//  InPlayerSDK
//
//  Created by Oliver Dimitrov on 5/5/20.
//  Copyright © 2020 InPlayer. All rights reserved.
//

import Foundation

public struct InPlayerExternalFee: Codable {

    public let id: Int?
    public let paymentProviderId: Int?
    public let accessFeeId: Int?
    public let externalId: String?
    public let merchantId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case paymentProviderId = "payment_provider_id"
        case accessFeeId = "access_fee_id"
        case externalId = "external_id"
        case merchantId = "merchant_id"
    }
    
    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        paymentProviderId = try values.decodeIfPresent(Int.self, forKey: .paymentProviderId)
        accessFeeId = try values.decodeIfPresent(Int.self, forKey: .accessFeeId)
        externalId = try values.decodeIfPresent(String.self, forKey: .externalId)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
    }
    
    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(id, forKey: .id)
        try values.encodeIfPresent(paymentProviderId, forKey: .paymentProviderId)
        try values.encodeIfPresent(accessFeeId, forKey: .accessFeeId)
        try values.encodeIfPresent(externalId, forKey: .externalId)
        try values.encodeIfPresent(merchantId, forKey: .merchantId)
    }
}
