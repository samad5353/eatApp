//
//  HomeViewController.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
    
    func reloadHome() {
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.restuarents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestuarentTableViewCell", for: indexPath) as? RestuarentTableViewCell else { return UITableViewCell() }
        cell.setupCell(items: presenter?.restuarents?[indexPath.row])
        return cell
    }
}
