//
//  FavouriteContainer.swift
//  MimX
//
//  Created by Furkan Güryel on 8.11.2023.
//

import Foundation
import CoreData

class FavouriteVideosContainer {
    let persistentContainer : NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreVideo")
        persistentContainer.loadPersistentStores { _, error in
            if let error{
                print(error.localizedDescription)
            }
        }
    }
    
    
}
