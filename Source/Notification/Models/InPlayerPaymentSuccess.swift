//
//  InPlayerPaymentSuccess.swift
//  InPlayerSDK
//
//  Created by Kire Jankulovski on 2/22/22.
//

import Foundation

/// Payment success model
public struct InPlayerPaymentSuccess: Codable {
    public var itemId: Int?
    public var previewTitle: String?
    public var accessFeeId: Int?
    public var transaction: String?
    public var decsription: String?
    public var email: String?
    public var customerId: Int?
    public var formattedAmount: String?
    public var amount: Double?
    public var currency: String?
    public var status: String?
    public var timestamp: Double?
    public var code: Int?
    
    private enum CodingKeys: String, CodingKey {
        case itemId = "item_id"
        case previewTitle
        case accessFeeId = "access_fee_id"
        case transaction
        case decsription
        case email
        case customerId = "customer_id"
        case formattedAmount = "formatted_amount"
        case amount
        case currency = "currency_iso"
        case status
        case timestamp
        case code
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try values.decodeIfPresent(Int.self, forKey: .itemId)
        previewTitle = try values.decodeIfPresent(String.self, forKey: .previewTitle)
        accessFeeId = try values.decodeIfPresent(Int.self, forKey: .accessFeeId)
        transaction = try values.decodeIfPresent(String.self, forKey: .transaction)
        decsription = try values.decodeIfPresent(String.self, forKey: .decsription)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        formattedAmount = try values.decodeIfPresent(String.self, forKey: .formattedAmount)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        timestamp = try values.decodeIfPresent(Double.self, forKey: .timestamp)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }
}
