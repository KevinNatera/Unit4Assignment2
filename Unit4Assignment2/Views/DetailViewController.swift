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
    var randomPhoto = String() {
        didSet {
            ImageHelper.shared.getImage(urlStr: randomPhoto) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        self.cityImageOutlet.image = image
                        self.activitySpinner.stopAnimating()
                        self.activitySpinner.isHidden = true
                    }
                }
            }
        }
    }
    
    var cityName = String() {
        didSet {
            PhotoAPIHelper.shared.getPhoto(cityName: cityName) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let photoData):
                        self.randomPhoto = photoData.randomElement()!.largeImageURL
                    }
                }
            }
        }
    }

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
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        let favoritedPhoto = FavoritePhoto(date: Date(), cityName: cityName, imageURL: randomPhoto)
        DispatchQueue.global(qos: .utility).async {
            try? PhotoPersistenceHelper.manager.save(newPhoto: favoritedPhoto)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        activitySpinner.startAnimating()
    }
    

    private func loadData() {
        cityNameLabel.text = cityName.capitalized
        dateLabel.text = weatherInfo.date.replacingOccurrences(of: "-", with: " ")
        summaryLabel.text = weatherInfo.summary
        highLabel.text = "High: \(weatherInfo.temperatureHigh) F"
        lowLabel.text = "Low: \(weatherInfo.temperatureLow) F"
        sunRiseLabel.text = "Sunrise: \(weatherInfo.realSunRiseTime)"
        sunSetLabel.text = "Sunset: \(weatherInfo.realSunSetTime)"
        windSpeedLabel.text = "Wind: \(weatherInfo.windSpeed) mph"
        precipitationLabel.text = "Precipitation: \(weatherInfo.precipitationChance)"
    }

}
