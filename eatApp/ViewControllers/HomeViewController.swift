//
//  HomeViewController.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter()
        self.presenter?.delegate = self
        presenter?.checkIfRegionIdSet()
    }
}

extension HomeViewController: HomePresenterDelegate {
    func showRegionLocator() {
        // show region vc and set region id
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "RegionSelectorViewController") as? RegionSelectorViewController {
            viewController.onSelectedRegion = {
                self.presenter?.makeAPICallForRestuarents()
            }
            self.navigationController?.present(viewController, animated: true, completion: nil)
        }
    }
}
