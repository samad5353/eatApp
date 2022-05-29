//
//  FilterDetailTableViewCell.swift
//  eatApp
//
//  Created by Abdul Samad on 5/29/22.
//

import UIKit

class FilterDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(items: CuisinesData?, selectedData: [CuisinesData?]?) {
        titleLabel.text = items?.attributes?.name
        if let selectedData = selectedData {
            for each in selectedData where each?.id == items?.id {
                self.selectionImageView.isHighlighted = true
            }
        }
    }
}
