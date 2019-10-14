//
//  WeatherCollectionViewCell.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    
    func configureCell(weather: Weather ) {
        highLabel.text = "High: \(weather.temperatureHigh)"
        lowLabel.text = "Low: \(weather.temperatureLow)"
        dateLabel.text = weather.date.replacingOccurrences(of: "-", with: " ")
        imageOutlet.image = UIImage(named: weather.icon )
    }
}
