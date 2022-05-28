//
//  RestuarentTableViewCell.swift
//  eatApp
//
//  Created by Abdul Samad on 5/27/22.
//

import UIKit

class RestuarentTableViewCell: UITableViewCell {

    @IBOutlet weak var restuarentName: UILabel!
    @IBOutlet weak var restuarentLocation: UILabel!
    @IBOutlet weak var restuarentCuisine: UILabel!
    @IBOutlet weak var restuarentPriceIndicator: UILabel!
    @IBOutlet weak var restuarentImage: UIImageView!
    @IBOutlet weak var restuarentCuisineContainer: UIView!
    @IBOutlet weak var restuarentPriceContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        restuarentCuisineContainer.layer.cornerRadius = 2
        restuarentCuisineContainer.layer.borderWidth = 0.5
        restuarentCuisineContainer.layer.borderColor = UIColor.white.cgColor
        restuarentPriceContainer.layer.cornerRadius = 2
        restuarentPriceContainer.layer.borderWidth = 0.5
        restuarentPriceContainer.layer.borderColor = UIColor.white.cgColor
    }

    func setupCell(items: RestaurentData?) {
        self.restuarentName.text = items?.attributes?.name
        self.restuarentLocation.text = items?.attributes?.addressLine1
        restuarentImage.image = nil
        if let imageURL = items?.attributes?.imageURL, let url = URL(string:imageURL) {
            restuarentImage.af.setImage(withURL: url, placeholderImage: UIImage(named: "noImage"))
        }
        self.restuarentCuisine.text =  items?.attributes?.cuisine
        self.restuarentPriceIndicator.text = getPriceIndicator(range: items?.attributes?.priceLevel ?? 0)
    }
    
    private func getPriceIndicator(range: Int) -> String {
        switch range {
        case 1:
            return "$"
        case 2:
            return "$$"
        case 3:
            return "$$$"
        default:
            return ""
        }
    }
}
