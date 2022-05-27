//
//  HomePresenter.swift
//  eatApp
//
//  Created by Abdul Samad on 27/05/2022.
//

import Foundation

class HomePresenter {
    
    var regionId: String? {
        return UserDefaults.standard.string(forKey: "region_id")
    }
    
    init() {
        if regionId == nil {
            // 
        }
    }
}
