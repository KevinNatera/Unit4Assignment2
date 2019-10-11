//
//  ViewController.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherCollectionOutlet: UICollectionView!
    @IBOutlet weak var zipCodeTextFieldOutlet: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherData = [Weather]() {
        didSet {
            weatherCollectionOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
       loadDefaults()
    }
    
   
    
// MARK: - Private methods
    
    private func setUp() {
        let layout = weatherCollectionOutlet.collectionViewLayout as! UICollectionViewFlowLayout
              layout.scrollDirection = .horizontal
        zipCodeTextFieldOutlet.keyboardType = .numberPad
        zipCodeTextFieldOutlet.delegate = self
        weatherCollectionOutlet.delegate = self
        weatherCollectionOutlet.dataSource = self
    }
    
    private func loadData(zipCode: String) {
        
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { (result) in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    print(error)
                case let .success((lat, long)):
                    UserDefaults.standard.set(lat, forKey: "latitude")
                    UserDefaults.standard.set(long, forKey: "longitude")
                    WeatherAPIHelper.shared.getWeather(latitude: lat, longitude: long) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .failure(let error):
                                print(error)
                            case .success(let weatherDataFromOnline):
                                self.weatherData = weatherDataFromOnline
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func loadDefaults() {
        if let latitude = UserDefaults.standard.value(forKey: "latitude") as? Double, let longitude = UserDefaults.standard.value(forKey: "longitude") as? Double {
            WeatherAPIHelper.shared.getWeather(latitude: latitude, longitude: longitude) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let weatherDataFromOnline):
                        self.weatherData = weatherDataFromOnline
                    }
                }
            }
        }
    }
}

// MARK: - CollectionView and Textfield Methods

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherCollectionOutlet.dequeueReusableCell(withReuseIdentifier: "weather", for: indexPath) as! WeatherCollectionViewCell
        let weather = weatherData[indexPath.row]
        cell.configureCell(weather: weather)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 190)
    }

}

extension ViewController : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 5 {
            textField.resignFirstResponder()
            loadData(zipCode: textField.text!)
            weatherCollectionOutlet.reloadData()
        }
         
        weatherCollectionOutlet.reloadData()
    }
}

