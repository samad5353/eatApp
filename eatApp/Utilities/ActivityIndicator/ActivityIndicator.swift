//
//  ActivityIndicator.swift
//  eatApp
//
//  Created by Abdul Samad on 5/27/22.
//

import Foundation
import UIKit
import Lottie

class ActivityIndicator: UIView {
    
    @IBOutlet var container: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let animationView = AnimationView(name: "loader")
        animationView.frame = CGRect(x: self.frame.width / 2, y: self.frame.height / 2, width: 300, height: 300)
        animationView.center = self.center
        animationView.loopMode = .loop
        self.addSubview(animationView)
        animationView.play{ (finished) in
            // Do Something
        }
    }
}
