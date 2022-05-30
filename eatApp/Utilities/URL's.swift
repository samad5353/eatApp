//
//  URL.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import Foundation

struct APPURL {
    static let BaseURL = "https://api.eat-sandbox.co/consumer/v2/"
    
    struct Region {
        static let regions = "regions?"
    }
    struct Restuarents {
        static let restuarents = "restaurants?page=%d&region_id=%@"
    }
    struct Cuisines {
        static let cuisines = "cuisines?"
    }
    struct Neighbourhood {
        static let neighbourhood = "neighborhoods?"
    }
}
