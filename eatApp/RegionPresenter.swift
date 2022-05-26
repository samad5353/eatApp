//
//  RegionPresenter.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import Foundation

class RegionPresenter {
    
    var regions: [RegionData]?
    
    func getRegionsFromAPI() {
        // Make api call for regions
        NetworkManager.shared.makeAPI(urlString: APPURL.Region.regions, method: .get) { (response: RegionCodable?) in
            if response == nil {
                // throw error
                return
            }
            self.regions = response?.data
        }
    }
}
