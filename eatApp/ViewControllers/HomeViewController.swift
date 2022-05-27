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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestuarentTableViewCell", for: indexPath) as? RestuarentTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}
