//
//  VideosContainer.swift
//  MimX
//
//  Created by Furkan Güryel on 8.11.2023.
//

import Foundation
import CoreData

class VideosContainer{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "MimXDB")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print("Persistent Container failed \(error.localizedDescription)")
            }
        }
        
    }
    
}
