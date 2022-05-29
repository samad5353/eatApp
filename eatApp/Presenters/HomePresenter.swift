//
//  HomePresenter.swift
//  eatApp
//
//  Created by Abdul Samad on 27/05/2022.
//

import Foundation

@objc protocol HomePresenterDelegate: AnyObject {
    @objc optional func showRegionLocator()
    @objc optional func reloadHome()
}

class HomePresenter {
    
    var regionId: String? {
        return UserDefaults.standard.string(forKey: "region_id")
    }
    weak var delegate: HomePresenterDelegate?
    var restuarents: [RestaurentData]?
    var selectedPriceRange: Int = 0
    var filterArray = ["Cuisines", "Neighbourhood"]
    
    func checkIfRegionIdSet() {
        if self.regionId == nil {
            // show region selctor
            self.delegate?.showRegionLocator?()
        } else {
            // make api call for restaurents
            self.makeAPICallForRestuarents()
        }
    }
    
    func makeAPICallForRestuarents() {
        // make api call
        let url = String(format: APPURL.Restuarents.restuarents, "1")
        NetworkManager.shared.makeAPI(urlString: url, method: .get) { (response: RestuarentsCD?) in
            if response == nil {
                // throw error
                return
            }
            self.restuarents = response?.data
            self.delegate?.reloadHome?()
        }
    }
}
