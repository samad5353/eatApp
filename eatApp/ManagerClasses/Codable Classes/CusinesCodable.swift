//
//  CusinesCodable.swift
//  eatApp
//
//  Created by Abdul Samad on 5/29/22.
//

import Foundation

// MARK: - CuisinesCD
class CuisinesCD: Codable {
    var data: [CuisinesData]?
    var meta: CusinesMeta?
    
    init(data: [CuisinesData]?, meta: CusinesMeta?) {
        self.data = data
        self.meta = meta
    }
}

// MARK: - Datum
class CuisinesData: Codable {
    var id, type: String?
    var attributes: CusinesAttributes?
    
    init(id: String?, type: String?, attributes: CusinesAttributes?) {
        self.id = id
        self.type = type
        self.attributes = attributes
    }
}

// MARK: - Attributes
class CusinesAttributes: Codable {
    var name: String?
    
    init(name: String?) {
        self.name = name
    }
}

// MARK: - Meta
class CusinesMeta: Codable {
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
