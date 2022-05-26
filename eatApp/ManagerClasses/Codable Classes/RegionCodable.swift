//
//  RegionCodable.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import Foundation

// MARK: - RegionCodable
class RegionCodable: Codable {
    var data: [RegionData]?

    init(data: [RegionData]?) {
        self.data = data
    }
}

// MARK: - Datum
class RegionData: Codable {
    var id, type: String?
    var attributes: Attributes?

    init(id: String?, type: String?, attributes: Attributes?) {
        self.id = id
        self.type = type
        self.attributes = attributes
    }
}

// MARK: - Attributes
class Attributes: Codable {
    var name, countryCode: String?
    var phone: String?
    var imageURL: String?

    enum CodingKeys: String, CodingKey {
        case name
        case countryCode = "country_code"
        case phone
        case imageURL = "image_url"
    }

    init(name: String?, countryCode: String?, phone: String?, imageURL: String?) {
        self.name = name
        self.countryCode = countryCode
        self.phone = phone
        self.imageURL = imageURL
    }
}
