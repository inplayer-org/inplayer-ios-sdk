//
//  InPlayerGeoRestriction.swift
//  InPlayerSDK
//
//  Created by Oliver Dimitrov on 5/1/20.
//

import Foundation

/// Geo Restrictions model
public struct InPlayerGeoRestriction: Codable {
    public let id: Int?
    public let countryISO: String?
    public let countrySetId: Int?
    public let type: String?
    public let createdAt: Double?
    public let updatedAt: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case countryISO = "country_iso"
        case countrySetId = "country_set_id"
        case type = "type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        countryISO = try values.decodeIfPresent(String.self, forKey: .countryISO)
        countrySetId = try values.decodeIfPresent(Int.self, forKey: .countrySetId)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
    }
    
    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(id, forKey: .id)
        try values.encodeIfPresent(countryISO, forKey: .countryISO)
        try values.encodeIfPresent(countrySetId, forKey: .countrySetId)
        try values.encodeIfPresent(type, forKey: .type)
        try values.encodeIfPresent(createdAt, forKey: .createdAt)
        try values.encodeIfPresent(updatedAt, forKey: .updatedAt)
    }
}
