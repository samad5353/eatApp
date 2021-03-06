//
//  RegionCollectionViewCell.swift
//  eatApp
//
//  Created by Abdul Samad on 27/05/2022.
//

import UIKit
import AlamofireImage

class RegionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var regionImage: UIImageView!
    @IBOutlet weak var regionName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - SetupCell
    func setupCell(items: RegionData?) {
        self.containerView.layer.applyRegionCardsShadowCell()
        if let imageURL = items?.attributes?.imageURL, let url = URL(string:imageURL ) {
            regionImage.af.setImage(withURL: url)
        }
        self.regionName.text = items?.attributes?.name
    }
}
