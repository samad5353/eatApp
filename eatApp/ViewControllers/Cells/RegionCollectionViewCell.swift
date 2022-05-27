//
//  RegionCollectionViewCell.swift
//  eatApp
//
//  Created by Abdul Samad on 27/05/2022.
//

import UIKit

class RegionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var regionImage: UIImageView!
    @IBOutlet weak var regionName: UILabel!
    
    func setupCell(items: RegionData?) {
        self.regionName.text = items?.attributes?.name
    }
}
