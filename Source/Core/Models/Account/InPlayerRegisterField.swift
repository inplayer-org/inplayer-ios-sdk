import Foundation

/**
 Register Field Type enum
 ```
 case dropdown(options: [String: String]?)
 case radio(options: [String: String]?)
 case country(options: [InPlayerFieldCountry])
 case input
 case datepicker
 case checkbox
 case unknown
 ```
 */
public enum RegisterFieldType {
    /// When field type is `select` and provides additional options for a dropdown menu.
    case dropdown(options: [String: String]?)

    /// When field type is `radio` and provides additional options for a radio selective button.
    case radio(options: [String: String]?)

    /// When field type is `country` and provides additional options for a country selection.
    case country(options: [InPlayerFieldCountry])

    /// When field type is `input`.
    case input

    /// When field type is `datepicker`.
    case datepicker

    /// When field type is `checkbox`.
    case checkbox

    /// When field type cannot be determined.
    case unknown
}

private struct RegisterFieldTypeStrings {
    static let dropdown = "select"
    static let radio = "radio"
    static let country = "country"
    static let input = "input"
    static let datepicker = "datepicker"
    static let checkbox = "checkbox"
    static let unknown = "unknown"
}

/// Register Field Model
public struct InPlayerRegisterField : Codable {

    public let defaultValue : String?
    public let id : Int?
    public let label : String?
    public let name : String?
    public let placeholder : String?
    public let required : Bool?
    public let type : RegisterFieldType

    enum CodingKeys: String, CodingKey {
        case typeString = "type"
        case defaultValue = "default_value"
        case id = "id"
        case label = "label"
        case name = "name"
        case placeholder = "placeholder"
        case required = "required"
        case options
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        defaultValue = try values.decodeIfPresent(String.self, forKey: .defaultValue)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        placeholder = try values.decodeIfPresent(String.self, forKey: .placeholder)
        required = try values.decodeIfPresent(Bool.self, forKey: .required)

        let typeString = try values.decodeIfPresent(String.self, forKey: .typeString)
        switch typeString {
        case RegisterFieldTypeStrings.dropdown:
            let resource = try values.decodeIfPresent([String: String].self, forKey: .options)
            type = .dropdown(options: resource)
        case RegisterFieldTypeStrings.radio:
            let resource = try values.decodeIfPresent([String: String].self, forKey: .options)
            type = .radio(options: resource)
        case RegisterFieldTypeStrings.country:
            let frameworkBundle = Bundle(for: InPlayer.self)
            if let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("InPlayer.bundle"),
                let resourceBundle = Bundle(url: bundleURL),
                let path = resourceBundle.path(forResource: "countries", ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try JSONDecoder().decode([InPlayerFieldCountry].self, from: data)
                type = .country(options: response)
            } else {
                type = .country(options: [])
            }
        case RegisterFieldTypeStrings.input:
            type = .input
        case RegisterFieldTypeStrings.datepicker:
            type = .datepicker
        case RegisterFieldTypeStrings.checkbox:
            type = .checkbox
        default:
            type = .unknown
            let error = NSError(domain: "Error",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Unsupported register field type"])
            throw error
        }
    }

    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(defaultValue, forKey: .defaultValue)
        try values.encode(id, forKey: .id)
        try values.encode(label, forKey: .label)
        try values.encode(name, forKey: .name)
        try values.encode(placeholder, forKey: .placeholder)
        try values.encode(required, forKey: .required)

        switch type {
        case .dropdown(let options):
            try values.encode(options, forKey: .options)
            try values.encode(RegisterFieldTypeStrings.dropdown, forKey: .typeString)
        case .radio(let options):
            try values.encode(options, forKey: .options)
            try values.encode(RegisterFieldTypeStrings.radio, forKey: .typeString)
        case .country(let options):
            try values.encode(options, forKey: .options)
            try values.encode(RegisterFieldTypeStrings.country, forKey: .typeString)
        case .input:
            try values.encode(RegisterFieldTypeStrings.input, forKey: .typeString)
        case .datepicker:
            try values.encode(RegisterFieldTypeStrings.datepicker, forKey: .typeString)
        case .checkbox:
            try values.encode(RegisterFieldTypeStrings.checkbox, forKey: .typeString)
        default:
            try values.encode(RegisterFieldTypeStrings.unknown, forKey: .typeString)
        }
    }
}
