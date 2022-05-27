//
//  RegionSelectorViewController.swift
//  eatApp
//
//  Created by Abdul Samad on 26/05/2022.
//

import UIKit

class RegionSelectorViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @objc var onSelectedRegion: (() -> Void)?
    var presenter: RegionPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegionPresenter()
        presenter?.delegate = self
        presenter?.getRegionsFromAPI()
    }
}

extension RegionSelectorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.regions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCollectionViewCell", for: indexPath) as? RegionCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(items: presenter?.regions?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2 - 30, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let items = presenter?.regions?[indexPath.row].id {
            UserDefaults.standard.set(items, forKey: "region_id")
            self.dismiss(animated: true, completion: {
                self.onSelectedRegion?()
            })
        }
    }
}

extension RegionSelectorViewController: RegionPresenterDelegate {
    
    func reloadRegions() {
        self.collectionView.reloadData()
    }
}
