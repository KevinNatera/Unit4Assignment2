//
//  WeatherAPIHelper.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation


class WeatherAPIHelper {
    
    private init() {}
    
    static let shared = WeatherAPIHelper()

    func getWeather(latitude: Double, longitude: Double, completionHandler: @escaping (Result<[Weather],AppError>) -> () ) {
        
    let urlStr = "https://api.darksky.net/forecast/\(Secrets.apiKey)/\(latitude),\(longitude)"
    guard let url = URL(string: urlStr) else {
        completionHandler(.failure(.badURL))
        return
    }
    
    NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
        switch result {
        case .failure(let error):
            print(error)
        case .success(let data):
            do {
                let weatherInfo = try JSONDecoder().decode(WeatherResults.self, from: data)
                completionHandler(.success(weatherInfo.daily.data))
            } catch {
                completionHandler(.failure(.couldNotParseJSON(rawError: error)))
            }
        }
    }
  }
}
