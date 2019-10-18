//
//  FavoritesTableViewCell.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/17/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    lazy var imageOutlet: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        return image
     }()
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            constrainLabel()
     }
    
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func constrainLabel() {
        contentView.addSubview(imageOutlet)
        imageOutlet.translatesAutoresizingMaskIntoConstraints = false
        imageOutlet.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageOutlet.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageOutlet.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageOutlet.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
 }


}
