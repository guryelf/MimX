//
//  FavouriteVideos+CoreDataProperties.swift
//  MimX
//
//  Created by Furkan Güryel on 8.11.2023.
//
//

import Foundation
import CoreData


extension FavouriteVideos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteVideos> {
        return NSFetchRequest<FavouriteVideos>(entityName: "FavouriteVideos")
    }

    @NSManaged public var id: String?
    @NSManaged public var tags: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var videoURL: String?

}

extension FavouriteVideos : Identifiable {}
