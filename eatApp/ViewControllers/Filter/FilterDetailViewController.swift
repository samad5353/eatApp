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
    var tempSelectedArray = [CuisinesData?]()
    @objc var applyFilter: (() -> Void)?
    
// MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = presenter?.filterListingMode == .cusine ? "Cuisines" : "Neighbourhood"
        if tempSelectedArray.count == 0 {
            if presenter?.filterListingMode == .cusine && presenter?.selectedCuisine != nil {
                tempSelectedArray = presenter?.selectedCuisine ?? []
            } else if presenter?.filterListingMode == .neighbourhood && presenter?.selectedNeighbourhood != nil {
                tempSelectedArray = presenter?.selectedNeighbourhood ?? []
            }
        }
    }
// MARK: - IBACtion
    @IBAction func backButtonClicked(_ sender: UIControl) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyFilterButtonClicked(_ sender: UIButton) {
        if self.presenter?.filterListingMode == .cusine {
            self.presenter?.selectedCuisine = self.tempSelectedArray
        } else {
            self.presenter?.selectedNeighbourhood = self.tempSelectedArray
        }
        self.applyFilter?()
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - TableView Delegates
extension FilterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.filterListingMode == .cusine ? presenter?.cuinesArray?.count ?? 0 : presenter?.neighbourhoodArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterDetailTableViewCell", for: indexPath) as? FilterDetailTableViewCell else { return UITableViewCell() }
        cell.setupCell(items: presenter?.filterListingMode == .cusine ? presenter?.cuinesArray?[indexPath.row] : presenter?.neighbourhoodArray?[indexPath.row], selectedData: tempSelectedArray)        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.filterListingMode == .cusine ? "Cuisines" : "Neighbourhood"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FilterDetailTableViewCell {
            if cell.selectionImageView.isHighlighted {
                if presenter?.filterListingMode == .cusine {
                    // remove items from selected
                    let selectedCusine = presenter?.cuinesArray?[indexPath.row]
                    tempSelectedArray = tempSelectedArray.filter { $0?.id != selectedCusine?.id }
                    self.tableView.reloadData()
                } else {
                    // remove items from selected
                    let selectedneigh = presenter?.neighbourhoodArray?[indexPath.row]
                    tempSelectedArray = tempSelectedArray.filter { $0?.id != selectedneigh?.id }
                    self.tableView.reloadData()
                }
            } else {
                if presenter?.filterListingMode == .cusine {
                    // Add items to selected
                    let selectedCusine = presenter?.cuinesArray?[indexPath.row]
                    if tempSelectedArray.count > 0, selectedCusine?.id == "00000" {
                        // make selection of all cusines
                        tempSelectedArray.removeAll()
                        self.tableView.reloadData()
                        return
                    }
                    tempSelectedArray.append(selectedCusine)
                    self.tableView.reloadData()
                } else {
                    // Add items to selected
                    let neigh = presenter?.neighbourhoodArray?[indexPath.row]
                    if tempSelectedArray.count > 0, neigh?.id == "00000" {
                        // make selection of all neighbourhood
                        tempSelectedArray.removeAll()
                        self.tableView.reloadData()
                        return
                    }
                    tempSelectedArray.append(neigh)
                    self.tableView.reloadData()
                }
            }
        }
    }
}
