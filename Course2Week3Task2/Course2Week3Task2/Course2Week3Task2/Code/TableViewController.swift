//
//  TableViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var photoTableView: UITableView!
    private lazy var dataManager = PhotoProvider()
    private lazy var photos = [Photo]()
    
    override func viewDidLoad() {
        photos = dataManager.photos()
        photoTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseId)
        photoTableView.delegate = self
        photoTableView.dataSource = self
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseId) else { return UITableViewCell() }
        let photo = photos[indexPath.row]
        cell.imageView?.image = photo.image
        cell.textLabel?.text = photo.name
        cell.accessoryType = .detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected")
        photoTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Accessory selected")
    }
}

extension TableViewController {
    private enum Constants {
        static let reuseId = "reusableCell"
    }
}
