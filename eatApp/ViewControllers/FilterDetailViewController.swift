//
//  FilterDetailViewController.swift
//  eatApp
//
//  Created by Abdul Samad on 5/29/22.
//

import UIKit

class FilterDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = presenter?.filterListingMode == .cusine ? "Cuisines" : "Neighbourhood"
    }
    
    @IBAction func backButtonClicked(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FilterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.filterListingMode == .cusine ? presenter?.cuinesArray?.count ?? 0 : presenter?.neighbourhoodArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterDetailTableViewCell", for: indexPath) as? FilterDetailTableViewCell else { return UITableViewCell() }
        cell.setupCell(items: presenter?.filterListingMode == .cusine ? presenter?.cuinesArray?[indexPath.row] : presenter?.neighbourhoodArray?[indexPath.row], selectedData: presenter?.filterListingMode == .cusine ? presenter?.selectedCuisine : presenter?.selectedNeighbourhood)        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.filterListingMode == .cusine ? "Cuisines" : "Neighbourhood"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FilterDetailTableViewCell {
            if cell.selectionImageView.isHighlighted {
                if presenter?.filterListingMode == .cusine {
                    // remove items from selected index
                    let selectedCusine = presenter?.cuinesArray?[indexPath.row]
                    presenter?.selectedCuisine = presenter?.selectedCuisine.filter { $0?.id != selectedCusine?.id } ?? []
                    self.tableView.reloadData()
                } else {
                    let selectedneigh = presenter?.neighbourhoodArray?[indexPath.row]
                    presenter?.selectedNeighbourhood = presenter?.selectedNeighbourhood.filter { $0?.id != selectedneigh?.id } ?? []
                    self.tableView.reloadData()
                }
            } else {
                if presenter?.filterListingMode == .cusine {
                    let selectedCusine = presenter?.cuinesArray?[indexPath.row]
                    presenter?.selectedCuisine.append(selectedCusine)
                    self.tableView.reloadData()
                } else {
                    let neigh = presenter?.neighbourhoodArray?[indexPath.row]
                    presenter?.selectedNeighbourhood.append(neigh)
                    self.tableView.reloadData()
                }
            }
        }
    }
}
