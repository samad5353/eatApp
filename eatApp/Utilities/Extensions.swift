//
//  Extensions.swift
//  eatApp
//
//  Created by Abdul Samad on 5/27/22.
//

import Foundation
import UIKit

extension CALayer {
    func applyRegionCardsShadowCell(
        color: UIColor = .lightGray,
        alpha: Float = 0.5,
        layerX: CGFloat = 0,
        layerY: CGFloat = 2,
        blur: CGFloat = 9,
        spread: CGFloat = 0) {
            shadowColor = color.cgColor
            shadowOpacity = alpha
            shadowOffset = CGSize(width: layerX, height: layerY)
            shadowRadius = blur / 2.0
            if spread == 0 {
                shadowPath = nil
            } else {
                let dxX = -spread
                let rect = bounds.insetBy(dx: dxX, dy: dxX)
                shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
}
