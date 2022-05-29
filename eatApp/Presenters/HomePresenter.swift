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

enum FilterListing: Int {
    case cusine = 0
    case neighbourhood = 1
}

class HomePresenter {
    
    var regionId: String? {
        return UserDefaults.standard.string(forKey: "region_id")
    }
    weak var delegate: HomePresenterDelegate?
    var restuarents: [RestaurentData]?
    var selectedPriceRange: Int = 0
    var filterArray = ["Cuisines", "Neighbourhood"]
    var filterListingMode: FilterListing = .cusine
    var cuinesArray: [CuisinesData]?
    var neighbourhoodArray: [CuisinesData]?
    var selectedCuisine = [CuisinesData?]()
    var selectedNeighbourhood = [CuisinesData?]()
    
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
            self.makeAPICallForCuisines()
        }
    }
    
    func makeAPICallForCuisines() {
        NetworkManager.shared.makeAPI(urlString: APPURL.Cuisines.cuisines, method: .get, isSilentCall: true) { (response: CuisinesCD?) in
            if response == nil {
                // throw error
                return
            }
            self.cuinesArray = response?.data
            self.createAndAppendAllCuisine()
            self.makeAPICallForNeighbourhood()
        }
    }
    
    func makeAPICallForNeighbourhood() {
        NetworkManager.shared.makeAPI(urlString: APPURL.Neighbourhood.neighbourhood, method: .get, isSilentCall: true) { (response: CuisinesCD?) in
            if response == nil {
                // throw error
                return
            }
            self.neighbourhoodArray = response?.data
            self.createAndAppendAllNeighbourHood()
        }
    }
    
    func createAndAppendAllCuisine() {
        let attr = CusinesAttributes(name: "All Cuisines")
        let cuisine = CuisinesData(id: "00000", type: "cuisine", attributes: attr)
        self.cuinesArray?.insert(cuisine, at: 0)
    }
    
    func createAndAppendAllNeighbourHood() {
        let attr = CusinesAttributes(name: "All Neighbourhoods")
        let cuisine = CuisinesData(id: "00000", type: "neighbourhoods", attributes: attr)
        self.neighbourhoodArray?.insert(cuisine, at: 0)
    }
    
    func getFilterTextForCusines() -> String {
        var string = ""
        for each in self.selectedCuisine {
            if string == "" {
                string += each?.attributes?.name ?? ""
            } else {
                string += ", " + (each?.attributes?.name ?? "") 
            }
        }
        return "(\(string))"
    }
    
    func getFilterTextForNeighbourhood() -> String {
        var string = ""
        for each in self.selectedNeighbourhood {
            if string == "" {
                string += each?.attributes?.name ?? ""
            } else {
                string += ", " + (each?.attributes?.name ?? "")
            }
        }
        return "(\(string))"
    }
    
    func finalFilterApply() {
        
    }
}
