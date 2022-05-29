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
            if each.tag == 0 {
                each.backgroundColor = UIColor(named: "green")
            }
            for each in priceSelectionLabelCollection {
                if each.tag == 0 {
                    each.textColor = .white
                } else {
                    each.textColor = UIColor(named: "priceDeselect")
                }
            }
            presenter?.selectedPriceRange = 0
        }
    }
}

extension FilterViewController {
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        setupView()
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
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.filterArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        cell.filterLabel.text = presenter?.filterArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "FILTER BY"
    }
    
    
}
