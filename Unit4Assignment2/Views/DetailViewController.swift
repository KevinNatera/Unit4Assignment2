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
            if randomPhoto == "noImage" {
                self.cityImageOutlet.image = UIImage(named: randomPhoto)
                self.favoriteButtonOutlet.isHidden = true
                self.favoriteButtonOutlet.isEnabled = false
            } else {
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
}
    
    var cityName = String() {
        didSet {
            PhotoAPIHelper.shared.getPhoto(cityName: cityName) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let photoData):
                        
                        if photoData.count == 0 {
                            self.randomPhoto = "noImage"
                        } else if let photo = photoData.randomElement()?.largeImageURL {
                            self.randomPhoto = photo
                        } else {
                            self.randomPhoto = "noImage"
                        }
                    }
                }
            }
        }
    }
// MARK: - Outlets
    
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
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        let favoritedPhoto = FavoritePhoto(date: Date(), cityName: cityName, imageURL: randomPhoto)
        DispatchQueue.global(qos: .utility).async {
            try? PhotoPersistenceHelper.manager.save(newPhoto: favoritedPhoto)
        }
        let alert = UIAlertController.init(title: "Favorited!", message: "Photo has been successfully added to favorites.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
            (alertAction: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true)
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



