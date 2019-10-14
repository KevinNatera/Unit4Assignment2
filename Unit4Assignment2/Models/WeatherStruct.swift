//
//  WeatherStruct.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation

struct WeatherResults : Codable {
    let daily: WeatherWrapper
}

struct WeatherWrapper : Codable {
    let data: [Weather]
}

struct Weather : Codable {
    let icon: String
    let summary: String
    let time: Int
    let sunriseTime: Int
    let sunsetTime: Int
    let temperatureHigh: Double
    let temperatureLow: Double
    let windSpeed: Double
    let precipProbability: Double
    var precipitationChance: String {
        get {
            return "\(precipProbability * 100)%"
        }
    }
    var date : String {
        get {
            let date = NSDate(timeIntervalSince1970: TimeInterval(time)) as Date
            let df = DateFormatter()
            df.dateFormat = "MMM-dd-yyyy"
            return df.string(from:date)
        }
    }
    var realSunRiseTime: String {
        get {
            let date = NSDate(timeIntervalSince1970: TimeInterval(sunriseTime)) as Date
                       let df = DateFormatter()
                       df.dateFormat = "hh:mm a"
                       df.amSymbol = "AM"
                       df.pmSymbol = "PM"
                       return df.string(from:date)
        }
    }
    var realSunSetTime: String {
        get {
            let date = NSDate(timeIntervalSince1970: TimeInterval(sunsetTime)) as Date
                       let df = DateFormatter()
                       df.dateFormat = "hh:mm a"
                       df.amSymbol = "AM"
                       df.pmSymbol = "PM"
                       return df.string(from:date)
        }
    }
}
