//
//  HomeViewController.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter: HomePresenter?
    var searchActive : Bool = false
    let blankView = UIView(frame: CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 120))

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter()
        self.presenter?.delegate = self
        presenter?.checkIfRegionIdSet()
    }
    
    @IBAction func filterButtonClicked(_ sender: UIControl) {
        self.performSegue(withIdentifier: "showFilter", sender: nil)
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
        blankView.removeFromSuperview()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (presenter?.restuarents?.count ?? 0) - 10 {
            if presenter?.pageTotalCount != presenter?.restuarents?.count {
                presenter?.currentPage += 1
                if presenter?.filterCompletedURL == "" {
                    presenter?.makeAPICallForRestuarents()
                } else {
                    presenter?.makeAPICallForRestuarents(url: presenter?.filterCompletedURL ?? "")
                }
            }
        }
    }
}

extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilter" {
            if let navController = segue.destination as? UINavigationController, let viewController = navController.viewControllers.first as? FilterViewController {
                viewController.presenter = self.presenter
            }
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        blankView.removeFromSuperview()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        searchBar.showsCancelButton = true
        if searchActive {
            blankView.backgroundColor = .black.withAlphaComponent(0.5)
            self.view.addSubview(blankView)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchKey = searchText
        presenter?.makeAPICallForSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.showsCancelButton = false
        searchBar.searchTextField.text = ""
        searchBar.searchTextField.resignFirstResponder()
        presenter?.searchKey = ""
        presenter?.makeAPICallForRestuarents()
    }
}
