//
//  RegionPresenter.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import Foundation

@objc protocol RegionPresenterDelegate: AnyObject {
    @objc optional func reloadRegions()
}

class RegionPresenter {
    
    var regions: [RegionData]?
    weak var delegate: RegionPresenterDelegate?
    
    func getRegionsFromAPI() {
        // Make api call for regions
        NetworkManager.shared.makeAPI(urlString: APPURL.Region.regions, method: .get) { (response: RegionCodable?) in
            if response == nil {
                // throw error
                return
            }
            self.regions = response?.data
            self.delegate?.reloadRegions?()
        }
    }
}
