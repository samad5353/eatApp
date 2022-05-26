//
//  RegionSelectorViewController.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import UIKit

class RegionSelectorViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: RegionPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegionPresenter()
        presenter?.getRegionsFromAPI()
    }
}

extension RegionSelectorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.regions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
