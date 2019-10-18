//
//  FavoriteViewController.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/13/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    lazy var tableOutlet: UITableView = {
        var table = UITableView()
        table.rowHeight = 125
        table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "favorites")
        return table
    }()
    
    var favorites = [FavoritePhoto]()
      
       
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        constrainTableView()
    }
 
  private func constrainTableView() {
    view.addSubview(tableOutlet)
    tableOutlet.delegate = self
    tableOutlet.dataSource = self
    tableOutlet.translatesAutoresizingMaskIntoConstraints = false
    tableOutlet.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableOutlet.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableOutlet.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableOutlet.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    view.backgroundColor = .white
    tableOutlet.reloadData()
  }
    
    
    
    
    
    private func loadData() {
        DispatchQueue.global(qos: .utility).async {
            self.favorites = try! PhotoPersistenceHelper.manager.getPhotos()
        }
    }
    

}

extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorites") as! FavoritesTableViewCell
        let favorite = favorites[indexPath.row]
        
        ImageHelper.shared.getImage(urlStr: favorite.imageURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.imageOutlet.image = image
                }
            }
        }
        return cell
    }
    
    
}
