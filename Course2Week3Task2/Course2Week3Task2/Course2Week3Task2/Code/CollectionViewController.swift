//
//  CollectionViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    private lazy var dataManager = PhotoProvider()
    private lazy var photos = [Photo]()
    
    override func viewDidLoad() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photos = dataManager.photos()
        photoCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: Constants.reuseId)
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseId, for: indexPath)
        guard let photoCell = cell as? PhotoCollectionViewCell else { return cell }
        let photo = photos[indexPath.row]
        photoCell.photoImageView.image = photo.image
        photoCell.photoNameLabel.text = photo.name
        
        return cell
    }
    
    
}

extension CollectionViewController {
    private enum Constants {
        static let reuseId = "reuseId"
    }
}
