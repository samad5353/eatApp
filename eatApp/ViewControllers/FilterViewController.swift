//
//  FilterViewController.swift
//  eatApp
//
//  Created by Abdul Samad on 5/28/22.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var priceSelectionCollection: [UIControl]!
    @IBOutlet var priceSelectionLabelCollection: [UILabel]!
    
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        for each in priceSelectionCollection {
            each.layer.cornerRadius = 5
            each.backgroundColor = .clear
            each.layer.borderWidth = 1
            each.layer.borderColor = UIColor.separator.cgColor
            if each.tag == presenter?.selectedPriceRange {
                each.backgroundColor = UIColor(named: "green")
            }
            for each in priceSelectionLabelCollection {
                if each.tag == presenter?.selectedPriceRange {
                    each.textColor = .white
                } else {
                    each.textColor = UIColor(named: "priceDeselect")
                }
            }
        }
    }
}

extension FilterViewController {
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        presenter?.selectedCuisine.removeAll()
        presenter?.selectedNeighbourhood.removeAll()
        presenter?.selectedPriceRange = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyFilterButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.presenter?.finalFilterApply()
        })
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        presenter?.selectedCuisine.removeAll()
        presenter?.selectedNeighbourhood.removeAll()
        presenter?.selectedPriceRange = 0
        presenter?.filterCompletedURL = ""
        setupView()
        tableView.reloadData()
    }
    
    @IBAction func priceSelectionButtonClicked(_ sender: UIControl) {
        for each in priceSelectionCollection {
            if each.tag == sender.tag {
                sender.backgroundColor = UIColor(named: "green")
                presenter?.selectedPriceRange = sender.tag
            } else {
                each.backgroundColor = .clear
                each.layer.borderWidth = 1
                each.layer.borderColor = UIColor.separator.cgColor
            }
        }
        
        for each in priceSelectionLabelCollection {
            if each.tag == sender.tag {
                each.textColor = .white
            } else {
                each.textColor = UIColor(named: "priceDeselect")
            }
        }
    }
    
    private func showDetails() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "FilterDetailViewController") as? FilterDetailViewController {
            viewController.presenter = presenter
            viewController.applyFilter = {
                self.tableView.reloadData()
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.filterArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        cell.filterLabel.text = presenter?.filterArray[indexPath.row]
        if indexPath.row == 0 {
            cell.filterType.text = ""
            if presenter?.selectedCuisine.count == 0 || presenter?.selectedCuisine.count == nil {
                cell.filterType.text = "(all)"
            } else {
                // append all filters
                cell.filterType.text = presenter?.getFilterTextForCusines()
            }
        } else {
            cell.filterType.text = ""
            if presenter?.selectedNeighbourhood.count == 0 || presenter?.selectedNeighbourhood.count == nil {
                cell.filterType.text = "(all)"
            } else {
                // append all filters
                cell.filterType.text = presenter?.getFilterTextForNeighbourhood()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "FILTER BY"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.filterListingMode = FilterListing(rawValue: indexPath.row) ?? .cusine
        showDetails()
    }
}
