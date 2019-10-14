//
//  PhotoPersistenceHelper.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/13/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation

struct PhotoPersistenceHelper {
    
    static let manager = PhotoPersistenceHelper()

    func save(newPhoto: FavoritePhoto) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    
    func getPhotos() throws -> [FavoritePhoto] {
        return try persistenceHelper.getObjects()
    }
    
    func deletePhoto(withDate: Date) throws {
        do {
            let photos = try getPhotos()
            let newPhotos = photos.filter { $0.date != withDate }
            try persistenceHelper.replace(elements: newPhotos)
        }
    }
    
    
    private let persistenceHelper = PersistenceHelper<FavoritePhoto>(fileName: "favoritePhotos.plist")

    private init() {}
}
