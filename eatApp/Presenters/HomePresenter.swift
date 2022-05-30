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
    var searchKey = ""
    var filterCompletedURL = ""
    var currentPage: Int = 1
    var pageTotalCount = 0
    var limit = 0
    
    func checkIfRegionIdSet() {
        // check if region id is set and show region selector
        if self.regionId == nil {
            // show region selctor
            self.delegate?.showRegionLocator?()
        } else {
            // make api call for restaurents
            self.makeAPICallForRestuarents()
        }
    }
    
    func makeAPICallForRestuarents(url: String = APPURL.Restuarents.restuarents, isfilterAPICalled: Bool = false) {
        // make api call
        let url = String(format: url, currentPage, regionId ?? "")
        NetworkManager.shared.makeAPI(urlString: url, method: .get) { (response: RestuarentsCD?) in
            if response == nil {
                // throw error
                return
            }
            self.restuarents = response?.data
            self.pageTotalCount = response?.meta?.totalCount ?? 0
            self.limit = response?.meta?.limit ?? 0
            if self.selectedPriceRange != 0 {
                self.restuarents = self.restuarents?.filter { $0.attributes?.priceLevel == self.selectedPriceRange }
            }
            self.delegate?.reloadHome?()
            if !isfilterAPICalled  {
                self.makeAPICallForCuisines()
            }
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
        // Create All Cusines to append cusines array
        let attr = CusinesAttributes(name: "All Cuisines")
        let cuisine = CuisinesData(id: "00000", type: "cuisine", attributes: attr)
        self.cuinesArray?.insert(cuisine, at: 0)
    }
    
    func createAndAppendAllNeighbourHood() {
        // Create All Neighbourhood to append cusines array
        let attr = CusinesAttributes(name: "All Neighbourhoods")
        let cuisine = CuisinesData(id: "00000", type: "neighbourhoods", attributes: attr)
        self.neighbourhoodArray?.insert(cuisine, at: 0)
    }
    
    func getFilterTextForCusines() -> String {
        // Get All Selected Cusines and return as single string as comma seperated for filter
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
        // Get All Selected Neighbourhood and return as single string as comma seperated for filter
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
    
    func getIdsForNeighbourhood() -> String {
        // Get All Selected Neighbourhood and return as single string of ids as comma seperated for api call
        var string = ""
        for each in self.selectedNeighbourhood {
            if string == "" {
                string += each?.id ?? ""
            } else {
                string += "," + (each?.id ?? "")
            }
        }
        return "&neighborhood_id=\(string)"
    }
    
    func getIdsForCusisines() -> String {
        // Get All Selected Cusisines and return as single string of ids as comma seperated for api call
        var string = ""
        for each in self.selectedCuisine {
            if string == "" {
                string += each?.id ?? ""
            } else {
                string += "," + (each?.id ?? "")
            }
        }
        return "&cuisine_id=\(string)"
    }
    
    func finalFilterApply() {
        // create filter api calls based on cusine selction and neighbourhood selection
        filterCompletedURL = ""
        if selectedCuisine.count > 0 {
            filterCompletedURL = getIdsForCusisines()
        }
        if selectedNeighbourhood.count > 0 {
            if filterCompletedURL == "" {
                filterCompletedURL = getIdsForNeighbourhood()
            } else {
                filterCompletedURL += getIdsForNeighbourhood()
            }
        }
        let finalURL = APPURL.Restuarents.restuarents + filterCompletedURL
        let url = String(format: finalURL, currentPage, regionId ?? "")
        makeAPICallForRestuarents(url: url, isfilterAPICalled: true)
    }
    
    func makeAPICallForSearch() {
        // api call for search query
        let searchQuery = "&q=\(self.searchKey)"
        let finalurl = APPURL.Restuarents.restuarents + searchQuery
        makeAPICallForRestuarents(url: finalurl, isfilterAPICalled: true)
    }
}
