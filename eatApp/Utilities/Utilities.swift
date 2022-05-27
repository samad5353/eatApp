//
//  Utilities.swift
//  eatApp
//
//  Created by Abdul Samad on 5/27/22.
//

import Foundation
import UIKit

class Utility {
    
    static let shared = Utility()
    private var activityIndicator: ActivityIndicator?
    
    func showActivity() {
        DispatchQueue.main.async {
            if self.activityIndicator != nil {
                self.activityIndicator?.removeFromSuperview()
            }
            self.activityIndicator = ActivityIndicator(frame: UIScreen.main.bounds)
            let keyWindow = UIApplication.shared.connectedScenes
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                if let activityIndictor = self.activityIndicator {
                    topController.view.addSubview(activityIndictor)
                    topController.view.bringSubviewToFront(activityIndictor)
                }
            }
        }
    }
    
    func hideActivity() {
        DispatchQueue.main.async {
            self.activityIndicator?.removeFromSuperview()
            self.activityIndicator = nil
        }
    }
}
