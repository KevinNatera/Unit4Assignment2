//
//  DetailViewController.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/13/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var weatherInfo: Weather!
    var cityName = String()

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityImageOutlet: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    

    private func loadData() {
        cityNameLabel.text = cityName.capitalized
        dateLabel.text = weatherInfo.date
        summaryLabel.text = weatherInfo.summary
        highLabel.text = "High: \(weatherInfo.temperatureHigh)"
        lowLabel.text = "Low: \(weatherInfo.temperatureLow)"
        sunRiseLabel.text = "Sun Rise: \(weatherInfo.realSunRiseTime)"
        sunSetLabel.text = "Sun Set: \(weatherInfo.realSunSetTime)"
        windSpeedLabel.text = "Wind Speed: \(weatherInfo.windSpeed)mph"
        precipitationLabel.text = "Precipitation: \(weatherInfo.precipitationChance)"
    }

}
