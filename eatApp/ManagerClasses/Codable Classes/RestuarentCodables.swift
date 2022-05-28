//
//  RestuarentCodables.swift
//  eatApp
//
//  Created by Abdul Samad on 5/27/22.
//

import Foundation

// MARK: - RestuarentsCD
class RestuarentsCD: Codable {
    var data: [RestaurentData]?
    var meta: Meta?
    var links: Links?
    
    init(data: [RestaurentData]?, meta: Meta?, links: Links?) {
        self.data = data
        self.meta = meta
        self.links = links
    }
}

// MARK: - Datum
class RestaurentData: Codable {
    var id, type: String?
    var attributes: RestuarentAttributes?
    var relationships: Relationships?
    
    init(id: String?, type: String?, attributes: RestuarentAttributes?, relationships: Relationships?) {
        self.id = id
        self.type = type
        self.attributes = attributes
        self.relationships = relationships
    }
}

// MARK: - Attributes
class RestuarentAttributes: Codable {
    var name: String?
    var priceLevel: Int?
    var phone, menuURL: String?
    var difficult: Bool?
    var cuisine: String?
    var imageURL: String?
    var latitude, longitude: Double?
    var addressLine1, ratingsAverage: String?
    var ratingsCount: Int?
    var labels: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case priceLevel = "price_level"
        case phone
        case menuURL = "menu_url"
        case difficult, cuisine
        case imageURL = "image_url"
        case latitude, longitude
        case addressLine1 = "address_line_1"
        case ratingsAverage = "ratings_average"
        case ratingsCount = "ratings_count"
        case labels
    }
    
    init(name: String?, priceLevel: Int?, phone: String?, menuURL: String?, difficult: Bool?, cuisine: String?, imageURL: String?, latitude: Double?, longitude: Double?, addressLine1: String?, ratingsAverage: String?, ratingsCount: Int?, labels: [String]?) {
        self.name = name
        self.priceLevel = priceLevel
        self.phone = phone
        self.menuURL = menuURL
        self.difficult = difficult
        self.cuisine = cuisine
        self.imageURL = imageURL
        self.latitude = latitude
        self.longitude = longitude
        self.addressLine1 = addressLine1
        self.ratingsAverage = ratingsAverage
        self.ratingsCount = ratingsCount
        self.labels = labels
    }
}

// MARK: - Relationships
class Relationships: Codable {
    var region: Region?
    
    init(region: Region?) {
        self.region = region
    }
}

// MARK: - Region
class Region: Codable {
    var data: DataClass?
    
    init(data: DataClass?) {
        self.data = data
    }
}

// MARK: - DataClass
class DataClass: Codable {
    var id, type: String?
    
    init(id: String?, type: String?) {
        self.id = id
        self.type = type
    }
}

// MARK: - Links
class Links: Codable {
    var first, last: String?
    
    init(first: String?, last: String?) {
        self.first = first
        self.last = last
    }
}

// MARK: - Meta
class Meta: Codable {
    var limit, totalPages, totalCount, currentPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case limit
        case totalPages = "total_pages"
        case totalCount = "total_count"
        case currentPage = "current_page"
    }
    
    init(limit: Int?, totalPages: Int?, totalCount: Int?, currentPage: Int?) {
        self.limit = limit
        self.totalPages = totalPages
        self.totalCount = totalCount
        self.currentPage = currentPage
    }
}
