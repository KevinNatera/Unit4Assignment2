//
//  PhotoStruct.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/13/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation

struct PhotoWrapper: Codable {
    let hits: [Photo]
}

struct Photo: Codable {
    let id: Int
    let largeImageURL: String
}

struct FavoritePhoto: Codable {
    let date: Date
    let cityName: String
    let imageURL: String
}
