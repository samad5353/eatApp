//
//  HomeViewController.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import UIKit

class HomeViewController: UIViewController {

    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter()
    }
}
